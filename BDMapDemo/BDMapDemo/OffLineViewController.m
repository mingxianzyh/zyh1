//
//  OffLineViewController.m
//  BDMapDemo
//
//  Created by sunlight on 14-5-19.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "OffLineViewController.h"
#import "CityListTableViewCell.h"
#import "Reachability.h"

@interface OffLineViewController ()

//百度离线服务
@property (nonatomic,strong) BMKOfflineMap *offlineMap;
//所有城市表格中展开section集合--NSNumber
@property (nonatomic,strong) NSMutableArray *openSections;
//已下载城市列表中展开section集合--NSNumber
@property (nonatomic,strong) NSMutableArray *downOpenSections;
//城市列表
@property (nonatomic,strong) NSArray *allCityList;
//已下载城市列表(整理前)
@property (nonatomic,strong) NSMutableDictionary *downLoadCityDictionary;
//已下载城市列表(整理后) 第一个元素为BMKOLSearchRecord，第二个元素为sonLists(NSArray)
@property (nonatomic,strong) NSArray *downLoadRecords;

@end

@implementation OffLineViewController

static NSString *identify = @"CityCell";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"离线地图管理";
    self.titleSegment.selectedSegmentIndex = 0;
    self.downLoadListTableView.hidden = YES;
    self.cityListTableView.hidden = NO;
    //初始化在线服务
    _offlineMap = [[BMKOfflineMap alloc] init];
    //获取所有城市列表
    _allCityList = [_offlineMap getOfflineCityList];
    //初始化数组
    _openSections = [[NSMutableArray alloc] init];
    _downOpenSections = [[NSMutableArray alloc] init];
    //获取各城市离线地图更新信息
    [self genOffLineCitys];
    [self.cityListTableView registerNib:[UINib nibWithNibName:@"CityListTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [self.downLoadListTableView registerNib:[UINib nibWithNibName:@"CityListTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
}

- (void)viewWillAppear:(BOOL)animated{

    self.offlineMap.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{

    self.offlineMap.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeSegment:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.cityListTableView.hidden = NO;
            self.downLoadListTableView.hidden = YES;
            [self.cityListTableView reloadData];
            break;
        }
        case 1:{
            self.downLoadListTableView.hidden = NO;
            self.cityListTableView.hidden = YES;
            [self.downLoadListTableView reloadData];
            break;
        }
        default:
            break;
    }
}
#pragma private method
//获取已存储离线地图
- (void)genOffLineCitys{
    NSArray *array1 = [_offlineMap getAllUpdateInfo];
    //仅用于测试
    //[self deleteAllOffMaps:array1];
    NSMutableDictionary *offLineDictionary = [[NSMutableDictionary alloc] init];
    for (BMKOLUpdateElement *element in array1) {
        [offLineDictionary setObject:element forKey:[NSNumber numberWithInt:element.cityID]];
    }
    _downLoadCityDictionary = offLineDictionary;
    
    //预计里面装的是NSArray，NSArray的第一个
    NSMutableArray *classifyRecords = [[NSMutableArray alloc] init];
    //循环城市列表
    for(BMKOLSearchRecord *record in _allCityList){
        //全国与直辖市
        if (record.cityType == 0 || record.cityType == 2) {
            if ([offLineDictionary objectForKey:[NSNumber numberWithInt:record.cityID]]) {
                NSArray *array = @[record];
                [classifyRecords addObject:array];
            }
        //省份地图判断
        }else if(record.cityType == 1){
            NSMutableArray *sonArray = [[NSMutableArray alloc] init];
            for (BMKOLSearchRecord *sonRecord in record.childCities) {
            if ([offLineDictionary objectForKey:[NSNumber numberWithInt:sonRecord.cityID]]) {
                [sonArray addObject:sonRecord];
                }
            }
            if ([sonArray count] > 0) {
                NSArray *array = @[record,sonArray];
                [classifyRecords addObject:array];
            }
        }
    }
    _downLoadRecords = classifyRecords;
}

- (void)deleteAllOffMaps:(NSArray *)array{
    if (array) {
        for (BMKOLUpdateElement *element in array) {
            NSLog(@"%@",element);
            NSLog(@"%d",element.cityID);
            NSLog(@"%@",element.cityName);
            [_offlineMap remove:element.cityID];
        }
    }
}

//点击下载后按钮操作
- (void)clickDownLoad:(UIButton *)button{
    //判断网络连接
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == NotReachable) {
        [self showNetworkErrorMsg];
        return;
    }
    CityListTableViewCell *cell = (CityListTableViewCell *)[[[button superview] superview] superview];
    NSIndexPath *indexPath = [self.cityListTableView indexPathForCell:cell];
    //获取section代表的城市地图
    BMKOLSearchRecord *record = _allCityList[indexPath.section-1];
    if (indexPath.row != 0) {
        record = record.childCities[indexPath.row-1];
    }
    BMKOLUpdateElement *element = [_offlineMap getUpdateInfo:record.cityID];;
    ///下载状态, -1:未定义 1:正在下载　2:等待下载　3:已暂停　4:完成 5:校验失败 6:网络异常 7:读写异常 8:Wifi网络异常 9:未完成的离线包有更新包 10:已完成的离线包有更新包 11:没有完全下载完成的省份 12:该省份的所有城市都已经下载完成 13:该省份的部分城市需要更新
    NSLog(@"%d",element.status);
    switch (element.status) {
        //0为不存在
        case 0:{
            cell.downButton.hidden = YES;
            cell.downProgressView.hidden = NO;
            [cell.downloadIndicator startAnimating];

            //开始下载
            if([_offlineMap start:record.cityID]){
                
                NSLog(@"开始下载成功");
            }else{
                
                NSLog(@"开始下载失败");
            }
            
            break;
        }
        case 3:{
            cell.downButton.hidden = YES;
            [cell.downloadIndicator startAnimating];
            cell.downProgressView.hidden = NO;
            if([_offlineMap start:record.cityID]){
                
                NSLog(@"继续下载成功");
            }else{
                
                NSLog(@"继续下载失败");
            }
            break;
        }
        case 6:{
            [self showNetworkErrorMsg];
            break;
        }
        case 9:{
            cell.downButton.hidden = YES;
            [cell.downloadIndicator startAnimating];
            cell.downProgressView.hidden = NO;
            if([_offlineMap update:record.cityID]){
                
                NSLog(@"开始更新成功");
            }else{
                
                NSLog(@"开始更新失败");
            }
            break;
        }
        case 10:{
            cell.downButton.hidden = YES;
            [cell.downloadIndicator startAnimating];
            cell.downProgressView.hidden = NO;
            if([_offlineMap update:record.cityID]){
                
                NSLog(@"开始更新成功");
            }else{
                
                NSLog(@"开始更新失败");
            }
            break;
        }
        case 11:{
            cell.downButton.hidden = YES;
            [cell.downloadIndicator startAnimating];
            cell.downProgressView.hidden = NO;
            if([_offlineMap update:record.cityID]){
                
                NSLog(@"开始更新成功");
            }else{
                
                NSLog(@"开始更新失败");
            }
            break;
        }
        case 13:{
            cell.downButton.hidden = YES;
            [cell.downloadIndicator startAnimating];
            cell.downProgressView.hidden = NO;
            [_offlineMap update:record.cityID];
            break;
        }
        default:
            break;
    }
    [self genOffLineCitys];
}

//根据城市ID获取在table上显示的行
- (NSIndexPath *)getRowByCityId:(NSInteger)cityId{
    NSInteger row = -1;
    NSInteger section = -1;
    for (int i = 0 ; i < [_allCityList count]; i++) {
        //第一个section为标题栏
        section = i+1;
        BMKOLSearchRecord *record = _allCityList[i];
        if (cityId == record.cityID) {
            row = 0;
            break;
        }
        if ([record.childCities count]>0) {
            for (int j = 0 ; j < [record.childCities count]; j++) {
                BMKOLSearchRecord *childRecord = record.childCities[j];
                if (cityId == childRecord.cityID) {
                    //第一行为父信息
                    row = j+1;
                    break;
                }
            }
        }
        if (row!=-1) {
            break;
        }
    }
    return [NSIndexPath indexPathForRow:row inSection:section];
}

- (void)clickDeleteButton:(UIButton *)button{
    CityListTableViewCell *cell = (CityListTableViewCell *)[[[button superview] superview] superview];
    NSIndexPath *indexPath = [self.downLoadListTableView indexPathForCell:cell];
    NSArray *array = self.downLoadRecords[indexPath.section-1];
    //说明点击的是第一行，行政区域，则不存在子城市地图
    BMKOLSearchRecord *record = array[0];
    if (indexPath.row == 0) {
        [_offlineMap remove:record.cityID];
    }else{
        NSMutableArray *sonRecords = array[1];
        //第一行为标题行,所以-1
        BMKOLSearchRecord *currentRecord = sonRecords[indexPath.row-1];
        [_offlineMap remove:currentRecord.cityID];
        //如果是展开的删除，则如果删除的时最后一个，则需要在删除缓存中的展开标记
        [sonRecords removeObject:currentRecord];
        if ([sonRecords count]==0) {
            [self.downOpenSections removeObject:[NSNumber numberWithInt:indexPath.section]];
        }
    }
    [self genOffLineCitys];
    //判断当前section在
    [self.downLoadListTableView reloadData];
}

//弹出网络连接失败对话框
- (void)showNetworkErrorMsg{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法下载,网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

#pragma table datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if (tableView == self.cityListTableView) {
        if (section == 0) {
            rows = 1;
        }else{
            if([_openSections containsObject:[NSNumber numberWithInt:section]]){
                //第一个section为标题栏
                BMKOLSearchRecord *record = _allCityList[section-1];
                //当前section为子count+主
                rows = [record.childCities count]+1;
                
            }else{
                rows = 1;
            }
        }
    }else{
        //判断是否展开
        if ([_downOpenSections containsObject:[NSNumber numberWithInt:section]]) {
            NSArray *array = self.downLoadRecords[section-1];
            NSArray *sonArray = array[1];
            rows = [sonArray count]+1;
        }else{
            rows = 1;
        }
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        CityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (tableView == self.cityListTableView) {
        if (indexPath.section==0&&indexPath.row == 0) {
            cell.gotoImage.hidden = YES;
            cell.cityNameLabel.text = @"名称";
            cell.typeLabel.text = @"类型";
            cell.sizeLabel.text = @"大小";
            cell.downButton.hidden = NO;
            cell.downButton.userInteractionEnabled = NO;
            [cell.downButton setTitle:@"状态" forState:UIControlStateNormal];
            [cell.downButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            NSString *buttonTitle = @"下载";
            cell.downButton.hidden = NO;
            cell.downProgressView.hidden = YES;
            cell.downButton.userInteractionEnabled = YES;
            [cell.downButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            BMKOLSearchRecord *record = self.allCityList[indexPath.section-1];
            //展开列表
            if ([_openSections containsObject:[NSNumber numberWithInt:indexPath.section]]) {
                //展开状态
                if (indexPath.row == 0) {
                    cell.downButton.hidden = YES;
                    cell.gotoImage.hidden = NO;
                    //图片旋转90°
                    cell.gotoImage.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
                }else{
                    cell.gotoImage.hidden = YES;
                    NSArray *childCities = record.childCities;
                    BMKOLSearchRecord *childRecord = childCities[indexPath.row-1];
                    //子结果类型为3,则判断是否已经下载完成，正在下载，则转动指示View(不显示进度条)
                    if (childRecord.cityType == 3) {
                        BOOL isDowning = NO;
                        NSInteger finishCount = 0;
                        NSInteger waitDownCount = 0;
                        for(BMKOLSearchRecord *sonRecord in childCities){
                            //城市类型为城市
                            if (sonRecord.cityType == 2) {
                                BMKOLUpdateElement *element = [_offlineMap getUpdateInfo:sonRecord.cityID];
                                //4 下载完成
                                if(element!=nil && element.status == 4){
                                    finishCount++;
                                }
                                //1 下载中，2等待下载
                                if (!isDowning && (element.status == 1 || element.status==2)) {
                                    isDowning = YES;
                                }
                                if (element.status == 2) {
                                    waitDownCount++;
                                }
                            }
                        }
                        //如果有一个子列表未下载完成--则显示继续下载,否则显示下载完成
                        if (finishCount == 0) {
                            buttonTitle = @"下载";
                        }else if (finishCount == [childCities count]-1) {
                            buttonTitle = @"已完成";
                        }else{
                            buttonTitle = @"继续下载";
                        }
                        //如果子列表正在下载，并且等待的列表数不为0
                        if (isDowning&&waitDownCount!=0) {
                            if (![cell.downloadIndicator isAnimating]) {
                                [cell.downloadIndicator startAnimating];
                                cell.downProgressView.hidden = YES;
                                cell.downButton.hidden = YES;
                            }
                        }
                    }
                    record = childRecord;
                }
            }else{
                //非展开状态(可下拉列表)
                if (indexPath.row == 0 && [record.childCities count] > 0) {
                    cell.downButton.hidden = YES;
                    cell.gotoImage.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
                    //因为在map委托中会进行cell UI操作，所以需要复原
                    if (!cell.downProgressView.hidden) {
                        cell.downProgressView.hidden = YES;
                    }
                    if (cell.downloadIndicator.isAnimating) {
                        [cell.downloadIndicator stopAnimating];
                    }
                }
            }
            BMKOLUpdateElement *element = [_offlineMap getUpdateInfo:record.cityID];
            cell.cityNameLabel.text = record.cityName;
            switch (record.cityType) {
                case 0:
                    cell.typeLabel.text = @"全国";
                    cell.gotoImage.hidden = YES;
                    break;
                case 1:
                    cell.typeLabel.text = @"省份";
                    cell.gotoImage.hidden = NO;
                    break;
                case 2:
                    cell.typeLabel.text = @"城市";
                    cell.gotoImage.hidden = YES;
                    break;
                case 3:
                    cell.typeLabel.text = @"省份";
                    break;
                default:
                    break;
            }
            cell.sizeLabel.text = [self getDataSizeString:record.size];
            [cell.downButton addTarget:self action:@selector(clickDownLoad:) forControlEvents:UIControlEventTouchUpInside];
            ///下载状态, -1:未定义 1:正在下载　2:等待下载　3:已暂停　4:完成 5:校验失败 6:网络异常 7:读写异常 8:Wifi网络异常 9:未完成的离线包有更新包 10:已完成的离线包有更新包 11:没有完全下载完成的省份 12:该省份的所有城市都已经下载完成 13:该省份的部分城市需要更新
            NSLog(@"%d",element.status);
            switch (element.status) {
                case 1:{
                    cell.downButton.hidden = YES;
                    [cell.downloadIndicator startAnimating];
                    cell.downProgressView.hidden = NO;
                    break;
                }
                case 2:{
                    buttonTitle = @"等待下载";
                    cell.downButton.userInteractionEnabled = NO;
                    break;
                }
                case 3:{
                    buttonTitle = @"继续下载";
                    break;
                }
                case 4:{
                    buttonTitle = @"已完成";
                    cell.downButton.userInteractionEnabled = NO;
                    cell.downProgressView.hidden = YES;
                    break;
                }
                case 6:{
                    //这种情况需要着重测试(会出现离线包出现此状态，但未断线)
                    if([_offlineMap remove:record.cityID]){
                    
                        NSLog(@"删除成功");
                    }else{
                    
                        NSLog(@"删除失败");
                    }
                    break;
                }
                case 9:{
                    buttonTitle = @"更新";
                    break;
                }
                case 10:{
                    buttonTitle = @"更新";
                    break;
                }
                case 11:{
                    buttonTitle = @"继续下载";
                    cell.downloadIndicator.hidden = NO;
                    cell.downProgressView.progress = 0.5;
                    break;
                }
                case 12:{
                    buttonTitle = @"已完成";
                    cell.downButton.userInteractionEnabled = NO;
                    break;
                }
                case 13:{
                    buttonTitle = @"更新";
                    break;
                }
                default:
                    break;
            }
            [cell.downButton setTitle:buttonTitle forState:UIControlStateNormal];
        }
    }else{
        if (indexPath.section==0&&indexPath.row == 0) {
            cell.gotoImage.hidden = YES;
            cell.cityNameLabel.text = @"名称";
            cell.typeLabel.text = @"类型";
            cell.sizeLabel.text = @"大小";
            cell.downButton.userInteractionEnabled = NO;
            [cell.downButton setTitle:@"操作" forState:UIControlStateNormal];
            [cell.downButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            NSString *buttonTitle = @"删除";
            cell.downButton.hidden = NO;
            cell.downProgressView.hidden = YES;
            cell.downButton.userInteractionEnabled = YES;
            cell.gotoImage.hidden = YES;
            //第一个section为标题栏
            NSArray *array = self.downLoadRecords[indexPath.section-1];
            BMKOLSearchRecord *currentRecord = array[0];
            if (currentRecord.cityType == 1) {
                //说明为展开状态
                if (indexPath.row != 0) {
                    NSArray *sonRecords = array[1];
                    currentRecord =sonRecords[indexPath.row-1];
                }else{
                    cell.gotoImage.hidden = NO;
                    cell.downButton.hidden = YES;
                    if ([self.downOpenSections containsObject:[NSNumber numberWithInt:indexPath.section]]) {
                        cell.gotoImage.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
                    }else{
                        cell.gotoImage.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
                    }
                }
            }
            //设置城市类型
            switch (currentRecord.cityType) {
                case 0:
                    cell.typeLabel.text = @"全国";
                    break;
                case 1:
                    cell.typeLabel.text = @"省份";
                    break;
                case 2:
                    cell.typeLabel.text = @"城市";
                    break;
                default:
                    break;
            }
            //设置按钮
            [cell.downButton setTitle:buttonTitle forState:UIControlStateNormal];
            [cell.downButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
            //设置城市名称
            cell.cityNameLabel.text = currentRecord.cityName;
            //设置地图大小
            cell.sizeLabel.text = [self getDataSizeString:currentRecord.size];
            [cell.downButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
    return cell;
}
//返回一共有多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.cityListTableView) {
        return [_allCityList count]+1;
    }else{
        return [_downLoadRecords count] +1;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.downLoadListTableView) {
        if ([self.downLoadRecords count]>0) {
            if (indexPath.section == 0) {
                return NO;
            }else{
                NSArray *records = self.downLoadRecords[indexPath.section-1];
                BMKOLSearchRecord *record = records[0];
                if (record.cityType==1) {
                    if (indexPath.row == 0) {
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    return YES;
                }
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.downLoadListTableView) {
        if (UITableViewCellEditingStyleDelete == editingStyle) {
//            BMKOLUpdateElement *element = self.downLoadCityList[indexPath.row];
//            [_offlineMap remove:[element cityID]];
        }
    }
}

#pragma tableview delegate
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.cityListTableView) {
        if(indexPath.row == 0){
            //如果是展开状态,则收缩
            if ([_openSections containsObject:[NSNumber numberWithInt:indexPath.section]]) {
                [_openSections removeObject:[NSNumber numberWithInt:indexPath.section]];
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                //判断当前section对应的数据是否为省份(算上标题栏)
                BMKOLSearchRecord *record = _allCityList[indexPath.section-1];
                if (record.cityType == 1 && [record.childCities count]>0) {
                    [_openSections addObject:[NSNumber numberWithInt:indexPath.section]];
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }
    }else{
        if (indexPath.row == 0) {
            //说明已经展开，再次点击需要收缩
            if ([self.downOpenSections containsObject:[NSNumber numberWithInt:indexPath.section]]) {
                [self.downOpenSections removeObject:[NSNumber numberWithInt:indexPath.section]];
                [self.downLoadListTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                //需要判断是否可以展开
                NSArray *array = self.downLoadRecords[indexPath.section-1];
                BMKOLSearchRecord *record = array[0];
                if (record.cityType == 1) {
                    [self.downOpenSections addObject:[NSNumber numberWithInt:indexPath.section]];
                    [self.downLoadListTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                }
            }
        }
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //标题栏不允许选择
    if (indexPath.section==0&&indexPath.row == 0) {
        return nil;
    }
    return indexPath;
}
#pragma map delegate
/**
 *返回通知结果
 *@param type 事件类型： TYPE_OFFLINE_UPDATE,TYPE_OFFLINE_ZIPCNT,TYPE_OFFLINE_UNZIP, TYPE_OFFLINE_ERRZIP, TYPE_VER_UPDATE, TYPE_OFFLINE_UNZIPFINISH, TYPE_OFFLINE_ADD
 *@param state 事件状态，当type为TYPE_OFFLINE_UPDATE时，表示正在下载或更新城市id为state的离线包，当type为TYPE_OFFLINE_ZIPCNT时，表示检测到state个离线压缩包，当type为TYPE_OFFLINE_ADD时，表示新安装的离线地图数目，当type为TYPE_OFFLINE_UNZIP时，表示正在解压第state个离线包，当type为TYPE_OFFLINE_ERRZIP时，表示有state个错误包，当type为TYPE_VER_UPDATE时，表示id为state的城市离线包有更新，当type为TYPE_OFFLINE_UNZIPFINISH时，表示扫瞄完成，成功导入state个离线包
 */
- (void)onGetOfflineMapState:(int)type withState:(int)state{

    if (type == TYPE_OFFLINE_UPDATE) {
        NSIndexPath *indexPath = [self getRowByCityId:state];
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo = [_offlineMap getUpdateInfo:state];
        CityListTableViewCell *cell = (CityListTableViewCell *)[self.cityListTableView cellForRowAtIndexPath:indexPath];
        if (self.cityListTableView.hidden == NO) {
            ///下载状态, -1:未定义 1:正在下载　2:等待下载　3:已暂停　4:完成 5:校验失败 6:网络异常 7:读写异常 8:Wifi网络异常 9:未完成的离线包有更新包 10:已完成的离线包有更新包 11:没有完全下载完成的省份 12:该省份的所有城市都已经下载完成 13:该省份的部分城市需要更新
            //BMKOLSearchRecord *record = _allCityList[indexPath.section-1];
            switch (updateInfo.status) {
                case 1:{
                    //正在下载中，更新进度View的值
                    //UI设置操作需要在主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSIndexPath *indexPath = [self getRowByCityId:state];
                        CityListTableViewCell *updateCell = (CityListTableViewCell *)[self.cityListTableView cellForRowAtIndexPath:indexPath];
                        if (updateCell) {
                            updateCell.downProgressView.hidden = NO;
                            updateCell.downButton.hidden = YES;
                            if (!updateCell.downloadIndicator.isAnimating) {
                                [updateCell.downloadIndicator startAnimating];
                            }
                            updateCell.downProgressView.progress = updateInfo.ratio/100.0;
                            if (updateInfo.ratio == 100) {
                                [updateCell.downloadIndicator stopAnimating];
                                [updateCell.downButton setTitle:@"已完成" forState:UIControlStateNormal];
                                [updateCell.downButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                                updateCell.downProgressView.progress = 0.0;
                                updateCell.downProgressView.hidden = YES;
                                updateCell.downButton.hidden = NO;
                                updateCell.downButton.userInteractionEnabled = NO;
                            }
                        }
                    });
                    break;
                }
                case 4:{
                    //下载完成后，隐藏控件，以及设置按钮标题
                    cell.downProgressView.hidden = YES;
                    [cell.downloadIndicator stopAnimating];
                    cell.downButton.hidden = NO;
                    cell.downButton.titleLabel.text = @"已下载";
                    cell.downButton.userInteractionEnabled = NO;
                    break;
                }
                case 6:{
                    //网络异常
                    [self showNetworkErrorMsg];
                }
                default:
                    break;
            }
        }else{
            
        }

        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }else if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }else if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }else if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
        NSLog(@"检测到%d个离线包",state);
        if(state==0)
        {
//            [self showImportMesg:state];
        }
    }else if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
        NSLog(@"有%d个离线包导入错误",state);
    }else if (type == TYPE_OFFLINE_UNZIPFINISH) {
        NSLog(@"成功导入%d个离线包",state);
        //导入成功state个离线包，导入成功后会回调此类型
//        [self showImportMesg:state];
    }

}

#pragma mark 包大小转换工具类（将包大小转换成合适单位）
-(NSString *)getDataSizeString:(int) nSize
{
	NSString *string = nil;
	if (nSize<1024)
	{
		string = [NSString stringWithFormat:@"%dB", nSize];
	}
	else if (nSize<1048576)
	{
		string = [NSString stringWithFormat:@"%dK", (nSize/1024)];
	}
	else if (nSize<1073741824)
	{
		if ((nSize%1048576)== 0 )
        {
			string = [NSString stringWithFormat:@"%dM", nSize/1048576];
        }
		else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;
            
            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }
                
            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;
                    
                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }
                    
                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%dMss", nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%d.%@M", nSize/1048576, decimalStr];
            }
        }
	}
	else	// >1G
	{
		string = [NSString stringWithFormat:@"%dG", nSize/1073741824];
	}
	
	return string;
}
@end
