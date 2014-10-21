//
//  FillViewController.m
//  UIOne
//
//  Created by sunlight on 14-5-26.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "FillViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "WSDRefreshFooterView.h"
#import "WsdNetWorkUtil.h"

@interface FillViewController ()
//公司tableView
@property (strong, nonatomic) IBOutlet UITableView *orgTableView;
//问卷tableView
@property (strong, nonatomic) IBOutlet UITableView *paperTableView;
//临时数据源
@property (strong, nonatomic) NSMutableArray *array;
//临时供应商数据源
@property (strong, nonatomic) NSMutableArray *partners;
//临时类型数据源
@property (strong, nonatomic) NSMutableArray *typeArray;
//临时试卷数据源
@property (strong, nonatomic) NSMutableDictionary *paperDictionary;

@property (strong, nonatomic) EGORefreshTableHeaderView *orgHeaderView;
@property (strong, nonatomic) WSDRefreshFooterView *orgFooterView;

@property (strong, nonatomic) EGORefreshTableHeaderView *paperHeaderView;
@property (strong, nonatomic) WSDRefreshFooterView *paperFooterView;

//公司是否加载中
@property (assign, nonatomic) BOOL isOrgLoading;
//试卷是否加载中
@property (assign, nonatomic) BOOL isPaperLoading;
@end

@implementation FillViewController

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
    //增加下拉刷新与上拉加载
    [self addHeaderAndFooterView];
    
    [self configViews];
    [self loadData];
    NSLog(@"%@",[WsdNetWorkUtil class]);
}

- (void)loadData{
    self.array = [NSMutableArray arrayWithArray:[UIFont familyNames]];
    self.partners = [NSMutableArray arrayWithObjects:@"常熟市起重机械设备厂",@"大连染料化工有限公司",@"东亚压缩厂",@"广东设计院",@"环保设备厂",@"金山化总设计",@"龙海公司",@"上海东方厂",@"上海工业锅炉厂",@"上海龙杰公司",@"苏州化工设备有限公司",@"新华压力厂",nil];
    self.typeArray = [NSMutableArray arrayWithObjects:@"卷烟",@"制丝",@"包装",@"原料",nil];
}

#pragma private method
- (void)configViews{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.orgTableView.tableFooterView = view;
    self.paperTableView.tableFooterView = view;
    self.orgTableView.layer.borderWidth = 1.0f;
    self.orgTableView.layer.borderColor = [[UIColor redColor] CGColor];

}


- (void)addHeaderAndFooterView{
    
    EGORefreshTableHeaderView *orgHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f,-self.orgTableView.bounds.size.height,self.orgTableView.bounds.size.width,self.orgTableView.bounds.size.height)];
    
    WSDRefreshFooterView *orgFooterView = [[WSDRefreshFooterView alloc] initWithFrame:CGRectMake(0.0f,self.orgTableView.bounds.size.height,self.orgTableView.bounds.size.width, self.orgTableView.bounds.size.height)];
    
    EGORefreshTableHeaderView *paperHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f,-self.paperTableView.bounds.size.height,self.paperTableView.bounds.size.width,self.paperTableView.bounds.size.height)];
    
    WSDRefreshFooterView *paperFooterView = [[WSDRefreshFooterView alloc] initWithFrame:CGRectMake(0.0f,self.paperTableView.bounds.size.height,self.paperTableView.bounds.size.width, self.paperTableView.bounds.size.height)];
    
    orgHeaderView.delegate = self;
    orgFooterView.delegate = self;
    paperHeaderView.delegate = self;
    paperFooterView.delegate = self;
    
    [orgHeaderView refreshLastUpdatedDate];
    [orgFooterView refreshLastUpdatedDate];
    [paperHeaderView refreshLastUpdatedDate];
    [paperFooterView refreshLastUpdatedDate];
    
    [self.orgTableView addSubview:orgHeaderView];
    [self.orgTableView addSubview:orgFooterView];
    [self.paperTableView addSubview:paperHeaderView];
    [self.paperTableView addSubview:paperFooterView];
    
    self.orgHeaderView = orgHeaderView;
    self.orgFooterView = orgFooterView;
    self.paperHeaderView = paperHeaderView;
    self.paperFooterView = paperFooterView;
}
- (void)finishOrgLoaded:(id)view{
    self.isOrgLoading = NO;
    if (view == self.orgHeaderView) {
        [self.orgHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.orgTableView];
        [self.orgHeaderView refreshLastUpdatedDate];
    }else if(view == self.orgFooterView) {
        [self.orgFooterView wsdRefreshScrollViewDataSourceDidFinishedLoading:self.orgTableView];
        [self.orgFooterView refreshLastUpdatedDate];
    }
}
- (void)finishPaperLoaded:(id)view{
    self.isPaperLoading = NO;
    if (view == self.paperHeaderView) {
        [self.paperHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.paperTableView];
        [self.paperHeaderView refreshLastUpdatedDate];
    }else if(view == self.paperFooterView){
        [self.paperFooterView wsdRefreshScrollViewDataSourceDidFinishedLoading:self.paperTableView];
        [self.paperFooterView refreshLastUpdatedDate];
    }
}

#pragma headerView delegate
//拖动完成时候时调用(在此委托中加载数据)
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    if (view == self.orgHeaderView) {
        self.isOrgLoading = YES;
        [self performSelector:@selector(finishOrgLoaded:) withObject:view afterDelay:2.0f];
    }else if(view == self.paperHeaderView) {
        self.isPaperLoading = YES;
        [self performSelector:@selector(finishPaperLoaded:) withObject:view afterDelay:2.0f];
    }
}
//返回数据是否在加载状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    if (view == self.orgHeaderView) {
        return self.isOrgLoading;
    }else{
        return self.isPaperLoading;
    }
}
//返回刷新时间时显示的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    if (view == self.orgHeaderView) {
        return [NSDate date];
    }else{
        return [NSDate date];
    }
}

#pragma footView delegate
//拖动完成时候时调用(在此委托中加载数据)
- (void)wsdRefreshTableFooterDidTriggerRefresh:(WSDRefreshFooterView*)view{
    if (view == self.orgFooterView) {
        self.isOrgLoading = YES;
        [self performSelector:@selector(finishOrgLoaded:) withObject:view afterDelay:2.0f];
    }else{
        self.isPaperLoading = YES;
        [self performSelector:@selector(finishPaperLoaded:) withObject:view afterDelay:2.0f];
    }
}
//返回数据是否在加载状态
- (BOOL)wsdRefreshTableFooterDataSourceIsLoading:(WSDRefreshFooterView*)view{
    
    if (view == self.orgFooterView) {
        return self.isOrgLoading;
    }else{
        return self.isPaperLoading;
    }
}
//返回刷新时间时显示的时间
- (NSDate*)wsdRefreshTableFooterDataSourceLastUpdated:(WSDRefreshFooterView*)view{
    if (view == self.orgFooterView) {
        return [NSDate date];
    }else{
    
        return [NSDate date];
    }
}

#pragma scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView == self.orgTableView) {
        if (self.orgHeaderView) {
            [self.orgHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
        if (self.orgFooterView) {
            [self.orgFooterView wsdRefreshScrollViewDidScroll:scrollView];
        }
    }else if(scrollView == self.paperTableView) {
        if (self.paperHeaderView) {
            [self.paperHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
        if (self.paperFooterView) {
            [self.paperFooterView wsdRefreshScrollViewDidScroll:scrollView];
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView == self.orgTableView) {
        if (self.orgHeaderView) {
            [self.orgHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        if (self.orgFooterView) {
            [self.orgFooterView wsdRefreshScrollViewDidEndDragging:scrollView];
        }
    }else if(scrollView == self.paperTableView) {
        if (self.paperHeaderView) {
            [self.paperHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        if (self.paperFooterView) {
            [self.paperFooterView wsdRefreshScrollViewDidEndDragging:scrollView];
        }
    }
}

#pragma tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.orgTableView) {
        return [self.partners count];
    }else{
        return [_array count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.orgTableView) {
        static NSString *IDENTIFY = @"ORGCELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFY];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFY];
            
        }
        cell.textLabel.text = self.partners[indexPath.row];
        return cell;
        
    }else{
        static NSString *IDENTIFY = @"CELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFY];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFY];
        }
        cell.textLabel.text = self.array[indexPath.row];
        return cell;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
