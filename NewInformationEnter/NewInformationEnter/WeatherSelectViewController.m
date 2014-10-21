//
//  WeatherSelectViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WeatherSelectViewController.h"

@interface WeatherSelectViewController (){

    BOOL _isLoading;
    
}

//轻击手势控制器
@property (nonatomic,strong) UITapGestureRecognizer *tapGestureReconizer;
//轻扫手势控制器
@property (nonatomic,strong) UISwipeGestureRecognizer *swipGestureReconizer;
//weather数据库Dao
@property (nonatomic,strong) WeatherDao *weatherDao;
//下拉刷新头部区域
@property (nonatomic,strong) EGORefreshTableHeaderView *headerView;

//titleView  Label
@property (nonatomic,strong) UILabel *label;

@end

@implementation WeatherSelectViewController

#pragma override
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //初始化手势控制器
        self.tapGestureReconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        self.swipGestureReconizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipToRight)];
        //设置轻扫手势控制的方向
        self.swipGestureReconizer.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建自定义视图
    [self createCustomView];
    self.weatherDao = [[WeatherDao alloc] init];
}

//view出现时增加通知
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //增加键盘隐藏的通知
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHiden) name:UIKeyboardWillHideNotification object:nil];
    //增加键盘显示的通知
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    //判断数据是否已经加载
    if (self.array==nil) {
        [self loadTableViewDatasource];
        //刷新更新时间
        [self.headerView refreshLastUpdatedDate];
    }
}

//view将消失时取消通知
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


//重写，防止出现键盘弹出的时候还能pop masterView
- (void)showPopoverView{
    [self.searchBar resignFirstResponder];
    [super showPopoverView];
}


#pragma private method
- (void)tapView{

    [self.searchBar resignFirstResponder];
}

- (void)swipToRight{
    [self.searchBar resignFirstResponder];
}

- (void)createCustomView{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置正常状态下按钮的背景图片
    [rightButton setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 75, 36);
    //设置按钮点击事件
    [rightButton addTarget:self action:@selector(editTable:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(768/2-100/2, 0, 100, 44)];
    label.textColor = [UIColor whiteColor];
    label.text = @"田间气象信息";
    self.navigationItem.titleView = label;
    self.label = label;
    //初始化默认加载第一个
    self.index = 0;
    
    //给表格加上下拉属性区域
    EGORefreshTableHeaderView *header = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0, -self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    header.delegate = self;
    [self.tableView addSubview:header];
    self.headerView = header;
}

- (void)editTable:(UIButton *)rightButton{
    
    [self.searchBar resignFirstResponder];
    if (self.tableView.editing) {
        //设置正常状态下按钮的背景图片
        [rightButton setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    }else{
        //设置正常状态下按钮的背景图片
        [rightButton setBackgroundImage:[UIImage imageNamed:@"finish"] forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }
}

//刷新数据
- (void)loadTableViewDatasource{
    _isLoading = YES;
    switch (_index) {
        case 0:{
            self.label.text = @"田间气象信息";
            self.array = [self.weatherDao queryAllWeatherInfo];
            self.dataArray = [NSArray arrayWithArray:self.array];
            [self.tableView reloadData];
            break;
        }
        case 1:{
            self.label.text = @"灾害信息";
            self.array = [NSMutableArray arrayWithArray:[UIFont familyNames]];
            self.dataArray = [NSArray arrayWithArray:self.array];
            [self.tableView reloadData];
            break;
        }
        case 2:{
            self.label.text = @"施肥记录";
            break;
        }
        case 3:{
            self.label.text = @"施药记录";
            break;
        }
        case 4:{
            self.label.text = @"生育期记录";
            break;
        }
        case 5:{
            self.label.text = @"农艺性状信息";
            break;
        }
        case 6:{
            self.label.text = @"育苗管理";
            break;
        }
        case 7:{
            self.label.text = @"移栽管理";
            break;
        }
        default:
            break;
    }
    _isLoading = NO;
}


#pragma notify method
//键盘隐藏将会调用此方法
- (void)keyboardWillHiden{
    //键盘不显示时，刷新数据
    if ([WSDStringUtils isNotBlank:self.searchBar.text]) {
        
        NSString *string = [NSString stringWithFormat:@"SELF LIKE[cd] '*%@*'",self.searchBar.text];
        switch (self.index) {
            case 0:{
                
                break;
            }
            case 1:{
                NSPredicate *predicate = [NSPredicate predicateWithFormat:string];
                self.dataArray = [self.array filteredArrayUsingPredicate:predicate];
                [self.tableView reloadData];
                break;
            }
            default:
                break;
        }
        
    }else{
        
        self.dataArray = [NSArray arrayWithArray:self.array];
        [self.tableView reloadData];
    }
    //隐藏时删除手势控制器
    [self.view removeGestureRecognizer:self.tapGestureReconizer];
    [self.view removeGestureRecognizer:self.swipGestureReconizer];

}

//键盘显示将会调用此方法
- (void)keyboardWillShow{
    
    //显示时增加手势控制器
    [self.view addGestureRecognizer:self.tapGestureReconizer];
    [self.view addGestureRecognizer:self.swipGestureReconizer];
}

#pragma tableView Delegate and datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){


}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        switch (self.index) {
            case 0:{
                
                break;
            }
            case 1:{
                break;
            }
            default:
                break;
        }
        //还需要从数据库中删除
        [self.array removeObjectAtIndex:indexPath.row];
        self.dataArray = [NSArray arrayWithArray:self.array];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"searchcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
        label.tag = 111;
        label.center = CGPointMake(768.0/2, 70.0/2);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    
    UILabel *label = (UILabel*)[cell viewWithTag:111];
    switch (self.index) {
        case 0:{
            WeatherInfoEntity * entity = _dataArray[indexPath.row];
            cell.detailTextLabel.text = entity.yearMonth;
            cell.textLabel.text = entity.townName;
            label.text = entity.partMonth;
            label.backgroundColor = [UIColor yellowColor];
            break;
        }
        case 1:{
            cell.textLabel.text = _dataArray[indexPath.row];
            cell.detailTextLabel.text = nil;
            label.text = nil;
            label.backgroundColor = [UIColor clearColor];
            break;
        }
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
//
//    return @"是否确认删除";
//}

//下拉刷新设置开始
#pragma scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //滚动时调用headView的滚动方法
    [self.headerView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //拖动时调用headView的拖动方法
    [self.headerView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma pull header delegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self loadTableViewDatasource];
    
    //[view egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    //加载完以后刷新状态(延迟执行--效果更好)
    [view performSelector:@selector(egoRefreshScrollViewDataSourceDidFinishedLoading:) withObject:self.tableView afterDelay:2.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _isLoading;
}
//设置刷新时返回时间代理
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}
//下拉刷新设置结束



// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    //查询的数据加载，由键盘隐藏的方法来执行
    [searchBar resignFirstResponder];
}
// called when cancel button pressed (cancel button can click on keyboard showing)
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    searchBar.text = nil;
    //初始的数据加载，由键盘隐藏的方法来执行
    [searchBar resignFirstResponder];
}

// called when search results button pressed
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2){
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
