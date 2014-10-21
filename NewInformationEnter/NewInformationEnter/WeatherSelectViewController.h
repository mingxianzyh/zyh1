//
//  WeatherSelectViewController.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WSDStringUtils.h"
#import "WeatherDao.h"
#import "EGORefreshTableHeaderView.h"

@interface WeatherSelectViewController : BaseViewController<EGORefreshTableHeaderDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

//所有数据集合
@property (nonatomic,strong) NSMutableArray *array;
//当前表格数据源结果集
@property (nonatomic,strong) NSArray *dataArray;

//当前主master选中标识
@property (nonatomic,assign) NSInteger index;

- (void)loadTableViewDatasource;

@end
