//
//  ViewController.m
//  下拉刷新
//
//  Created by sunlight on 14-5-4.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *sonArray;
@property (nonatomic,assign) BOOL isFirstLevelOpen;
@property (nonatomic,strong) CustomTableView *tableView;

//下拉headView
@property (nonatomic,strong) EGORefreshTableHeaderView *headerView;
//上拉footerView
@property (nonatomic,strong) WSDRefreshFooterView *footerView;
@property (nonatomic,assign) BOOL isLoading;

@property (nonatomic,assign) NSInteger capacity;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.capacity = 5;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.capacity];
    for (int i = 0 ; i < self.capacity; i++) {
        [array addObject:[NSString stringWithFormat:@"第%i级",i]];
    }
    self.dataArray = array;
    [self addSubView];
}

//增加自定义View
- (void)addSubView{
    
    CustomTableView *tableView = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    EGORefreshTableHeaderView *headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f-460,320 ,460)];
    headerView.delegate = self;
    [headerView refreshLastUpdatedDate];
    
    WSDRefreshFooterView *footerView = [[WSDRefreshFooterView alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height-20.0f, 320.0f, 460.0f)];
    footerView.delegate = self;
    [footerView refreshLastUpdatedDate];
    

    [tableView addSubview:headerView];
    [tableView addSubview:footerView];
    [self.view addSubview:tableView];
    
    
    self.tableView = tableView;
    self.headerView = headerView;
    self.footerView = footerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}


#pragma tableView resource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isFirstLevelOpen) {
        return [self.dataArray count]+[self.sonArray count];
    }else{
        return [self.dataArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;


#pragma headerView delegate

//拖动完成时候时调用(在此委托中加载数据)
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    dispatch_queue_t queue = dispatch_queue_create("loadData", NULL);
    dispatch_async(queue, ^{
        [self loadTableViewDataSource:WSDHeaderViewIdentify];
    });
}
//返回数据是否在加载状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{

    return self.isLoading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}


#pragma footerView delegate
//拖动完成时候时调用(在此委托中加载数据)
- (void)egoRefreshTableFooterDidTriggerRefresh:(WSDRefreshFooterView*)view{
    dispatch_queue_t queue = dispatch_queue_create("loadData", NULL);
    dispatch_async(queue, ^{
        [self loadTableViewDataSource:WSDFooterViewIdentify];
    });
    
}
//返回数据是否在加载状态
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(WSDRefreshFooterView*)view{
    
    return self.isLoading;
}
//返回刷新时间时显示的时间
- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(WSDRefreshFooterView*)view{

    return [NSDate date];
}



//加载tableView数据源
- (void)loadTableViewDataSource:(WSDViewIdentify) identify{
    
    self.isLoading = YES;
    [NSThread sleepForTimeInterval:2.0f];
    NSInteger begin = self.capacity;
    self.capacity = begin+10;
    if (identify == WSDHeaderViewIdentify) {
        for (int i = begin; i < self.capacity; i++) {
            [self.dataArray insertObject:[NSString stringWithFormat:@"第%i级",i] atIndex:0];
        }
    }else{
        for (int i = begin; i < self.capacity; i++) {
            [self.dataArray addObject:[NSString stringWithFormat:@"第%i级",i]];
        }
    }
    //在主线程完成UI操作
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self doneLoadTableViewDataSource:identify];
    });
}

- (void)doneLoadTableViewDataSource:(WSDViewIdentify)identify{
    self.isLoading = NO;
    switch (identify) {
        case WSDHeaderViewIdentify:
            [self.headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
            break;
        case WSDFooterViewIdentify:{
            [self.footerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
            break;
        }
        default:
            break;
    }
    //内容的高度
    CGFloat contentHeight = self.tableView.contentSize.height;
    //表格的高度
    CGFloat tableHeight = self.tableView.frame.size.height - self.tableView.contentInset.top - self.tableView.contentInset.bottom;
    //y坐标
    CGFloat y = MAX(contentHeight, tableHeight);
    CGRect frame = self.footerView.frame;
    frame.origin.y = y;
    self.footerView.frame = frame;

}

#pragma scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.headerView) {
        [self.headerView egoRefreshScrollViewDidScroll:scrollView];
    }
    if (self.footerView) {
        [self.footerView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (self.headerView) {
        [self.headerView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    if (self.footerView) {
        [self.footerView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

@end
