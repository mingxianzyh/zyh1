//
//  WeatherViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WeatherViewController.h"

//相关的一些设置在xib文件中
@interface WeatherViewController ()

//乡镇信息(应该换成对象)
@property (nonatomic,strong) NSArray *townInfos;
//旬信息
@property (nonatomic,strong) NSArray *partMonthInfos;
//弹出乡镇信息视图选择的行
@property (nonatomic,strong) NSIndexPath *selectedTownIndexPath;
//弹出旬信息视图选择的行
@property (nonatomic,strong) NSIndexPath *selectedPartMonthIndexPath;

@end

@implementation WeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _townInfos = [NSArray arrayWithObjects:@"徐汇区",@"长宁区",@"虹口区",@"宝山区",@"闵行区",@"嘉定区",@"浦东新区", nil];
        _partMonthInfos = [NSArray arrayWithObjects:@"上旬",@"中旬",@"下旬",@"全月",nil];
    }
    return self;
}

//编辑初始化方法
- (id)initWithWeatherInfo:(WeatherInfoEntity*) weatherInfo{
    
    self = [super init];
    if (self) {
        self.weatherInfo = weatherInfo;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createCustomView];
    
    [self createAssociateEntity];
}

#pragma private begin
//创建自定义View
- (void)createCustomView{
    //self.navigationItem.title = @"田间气象信息";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(768/2-100/2, 0, 100, 44)];
    label.text = @"田间气象信息";
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    //设置背景图片(这种方式会造成内存泄露--待验证)
    //    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"main2"]];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main2"]];
    [self.view insertSubview:backgroundView atIndex:0];
}

//textFields register first response
- (void) registerAllTextfields{

    [self.avgTemp resignFirstResponder];
    [self.avgSunHours resignFirstResponder];
    [self.rainFallAmount resignFirstResponder];
    [self.avgOppositeTemp resignFirstResponder];
    [self.hignTempDays resignFirstResponder];
}
#pragma private end


#pragma textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag==100||textField.tag==101||textField.tag==102) {
        return NO;
    }else{
        if (self.pickView) {
            [self.pickView removeFromSuperview];
            self.pickView = nil;
        }
        return YES;
    }
}        // return NO to disallow editing.

//只有点击了键盘，才会触发(如果键盘都没出现，则不会出现)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //103,104,105,106,107
    if (textField.tag>=103) {
        //string为单字符
        if (![WSDStringUtils isMemberOfDecialNumber:string]) {
            return NO;
        }
    }
    return YES;
}
#pragma textfield delegate end


//创建实体
- (void)createAssociateEntity{
    
    self.weatherDao = [[WeatherDao alloc] init];
    if (self.weatherInfo==nil) {
        self.weatherInfo = [[WeatherInfoEntity alloc] init];
    }
}

//设置当前实体值
- (void)installEntityValue{
    //非弹出值赋值
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    self.weatherInfo.yearMonth = _yearMonth.text;
    self.weatherInfo.avgTemp = [format numberFromString:_avgTemp.text];
    self.weatherInfo.avgSunHours = [format numberFromString:_avgSunHours.text];
    self.weatherInfo.avgOppositeTemp = [format numberFromString:_avgOppositeTemp.text];
    self.weatherInfo.hignTempDays = [format numberFromString:_hignTempDays.text];
    self.weatherInfo.rainFallAmount = [format numberFromString:_rainFallAmount.text];
}

//保存前的验证
- (BOOL)validateBeforeSave{
    
    if ([WSDStringUtils isBlank:self.yearMonth.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"年月不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }
    if ([WSDStringUtils isBlank:self.townName.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"乡镇不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }
    if ([WSDStringUtils isBlank:self.partMonth.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旬不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }
    if ([WSDStringUtils isBlank:self.avgTemp.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"平均温度不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }else{
        //判断输入是否合法
        if (![WSDStringUtils isDecialNumber:self.avgTemp.text]) {
            UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入合法的平均温度" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warnView show];
        return NO;
        }
    }
    if ([WSDStringUtils isBlank: self.avgSunHours.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"平均日照数不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }else{
        if (![WSDStringUtils isDecialNumber:self.avgSunHours.text]) {
            UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入合法的平均日照数" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warnView show];
        return NO;
        }
    }
    if ([WSDStringUtils isBlank:self.rainFallAmount.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"降水量不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }else{
        if (![WSDStringUtils isDecialNumber:self.rainFallAmount.text]) {
            UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入合法的降水量" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warnView show];
            return NO;
        }
    }
    if ([WSDStringUtils isBlank:self.avgOppositeTemp.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"平均相对温度不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }else{
        if (![WSDStringUtils isDecialNumber:self.avgOppositeTemp.text]) {
            UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入合法的平均相对温度" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warnView show];
            return NO;
        }
    }
    if ([WSDStringUtils isBlank:self.hignTempDays.text]) {
        UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"最高气温>=35˚C天数不可为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warnView show];
        return NO;
    }else{
        if (![WSDStringUtils isDecialNumber:self.hignTempDays.text]) {
            UIAlertView *warnView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入合法的最高气温天数" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warnView show];
            return NO;
        }
    }
    return YES;
}

#pragma private end

#pragma 自定义PickerView代理
- (void)selectedDate:(CustomPickerView*)pickerView{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM";
    self.yearMonth.text = [format stringFromDate:pickerView.date];
    
}


#pragma override
//保存数据的实现
- (void)saveData{
    //弹出视图和键盘失去响应
    [self touchDownBackground:nil];
    //执行校验
    if (![self validateBeforeSave]) {
        return;
    }
    //插入基础数据
    [self installEntityValue];
    NSDate *now = [NSDate date];
    //新增和更新的区别
    if (self.weatherInfo.id == nil) {
        //初始化当前对象信息
        UserEntity *loginUser = [UserEntity shareLoginUser];
        self.weatherInfo.orgId = loginUser.orgId;
        self.weatherInfo.orgName = loginUser.orgName;
        self.weatherInfo.orgCode = loginUser.orgCode;
        self.weatherInfo.createDate = now;
        self.weatherInfo.updateDate = now;
        DBResult result = [self.weatherDao insertWeatherInfo:self.weatherInfo];
        if (result == DBResultDataHasExists) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存错误,当前年月乡镇信息已经存在" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (result == DBResultSuccess){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
        
        }
    }else{
        self.weatherInfo.updateDate = now;
        [self.weatherDao updateWeatherInfo:self.weatherInfo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma popVListView delegate and datasource
//设置弹出视图的section rows
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger result ;
    switch (tableView.indexTag) {
        case 0:{
            result =  [_townInfos count];
            break;
        }
        case 1:{
            result = [_partMonthInfos count];
            break;
        }
        default:
            break;
    }
    return result;
}

//设置cell
- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"WeatherCell";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identify];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    //设置显示text
    if (tableView.indexTag == 0) {
        cell.textLabel.text = _townInfos[indexPath.row];
        if ([indexPath compare:self.selectedTownIndexPath]==NSOrderedSame) {
            cell.imageView.image = [UIImage imageNamed:@"selected"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"normal"];
        }
    }else if(tableView.indexTag == 1) {
        cell.textLabel.text = _partMonthInfos[indexPath.row];
        if ([indexPath compare:self.selectedPartMonthIndexPath]==NSOrderedSame) {
            cell.imageView.image = [UIImage imageNamed:@"selected"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"normal"];
        }
    }
    return cell;
}

//先执行选中(选中后视图就消失了，就不会调用不选中事件)
- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"selected"];
    //选中标记IndexPath需要分开，否则就会影响两个alertView的显示
    if (tableView.indexTag == 0) {
        self.townName.text = _townInfos[indexPath.row];
        self.selectedTownIndexPath = indexPath;
        //将选中后的属性设置到实体中
        self.weatherInfo.townName = self.townName.text;
    }else if (tableView.indexTag == 1) {
        self.partMonth.text = _partMonthInfos[indexPath.row];
        self.selectedPartMonthIndexPath = indexPath;
        //将选中后的属性设置到实体中
        self.weatherInfo.partMonth = self.partMonth.text;
    }
    [tableView dismiss];
}


#pragma alert view
//弹出年月PickerView
- (IBAction)alertYearMonthPickerView:(UITextField *)sender {
    //这里需要让所有textField取消为第一响应者(自身不需要)
    [self registerAllTextfields];
    
    if (self.pickView == nil) {
        self.pickView = [[CustomPickerView alloc] initWithFrame:CGRectMake(453, 52, 0, 0)];
        //datePicker.datePickerMode = UIDatePickerModeDate;
        //datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        //    [datePicker addTarget:self action:@selector(selectedDate:) forControlEvents:UIControlEventValueChanged];
        self.pickView.customDelegate = self;
        self.pickView.showsSelectionIndicator = YES;
        
        NSDate *date;
        //NSLog(@"%@",self.yearMonth.text);//为""
        //默认选择的年月
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM";
        if ([WSDStringUtils isNotBlank:self.yearMonth.text]) {
            date = [format dateFromString:self.yearMonth.text];
        }else{
            //第一次点击默认当前年月
            date = [NSDate date];
        }
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
        [self.pickView selectRow:components.year-1900 inComponent:0 animated:NO];
        [self.pickView selectRow:components.month-1 inComponent:1 animated:NO];
        
        self.pickView.date = date;
        self.yearMonth.text = [format stringFromDate:self.pickView.date];
        [self.view addSubview:self.pickView];
    }else{
        [self.pickView removeFromSuperview];
        self.pickView = nil;
    }
}

//弹出选择乡镇选择View
- (IBAction)alertTownSelectView:(UITextField *)sender {
    
    //先取消弹出的视图和键盘
    [self touchDownBackground:nil];
    //默认中心点
    ZSYPopoverListView *alertListView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    alertListView.titleName.text = @"请选择乡镇名称";
    alertListView.delegate = self;
    alertListView.datasource = self;
    alertListView.indexTag = 0;
    [alertListView show];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
//    view.backgroundColor = [UIColor redColor];
//    UIControl *_controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
//    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window addSubview:_controlForDismiss];
//    [window addSubview:view];
    
}
//弹出选择旬选择View
- (IBAction)alertPartMonthView:(UITextField *)sender {
    
    //先取消弹出的视图和键盘
    [self touchDownBackground:nil];
    //默认中心点
    ZSYPopoverListView *alertListView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    alertListView.titleName.text = @"请选择旬";
    alertListView.delegate = self;
    alertListView.datasource = self;
    alertListView.indexTag = 1;
    [alertListView show];
}


//接触背景后隐藏键盘等控件
- (IBAction)touchDownBackground:(id)sender{

    if (self.pickView!=nil) {
        [self.pickView removeFromSuperview];
        self.pickView = nil;
    }
    [self registerAllTextfields];
}

@end
