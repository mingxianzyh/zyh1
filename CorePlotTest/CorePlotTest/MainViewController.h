//
//  MainViewController.h
//  CorePlotTest
//
//  Created by sunlight on 14-8-29.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WsdLineViewController.h"
#import "WsdBarViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WsdLineViewControllerDelegate,WsdBarViewControllerDelegate>

@end
