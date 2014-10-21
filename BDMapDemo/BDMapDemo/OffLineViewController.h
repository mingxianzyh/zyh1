//
//  OffLineViewController.h
//  BDMapDemo
//
//  Created by sunlight on 14-5-19.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

//百度离线地图管理
@interface OffLineViewController : UIViewController<BMKOfflineMapDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *titleSegment;
@property (strong, nonatomic) IBOutlet UITableView *cityListTableView;
@property (strong, nonatomic) IBOutlet UITableView *downLoadListTableView;

- (IBAction)changeSegment:(UISegmentedControl *)sender;

@end
