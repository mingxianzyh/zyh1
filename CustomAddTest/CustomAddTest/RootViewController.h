//
//  RootViewController.h
//  CustomAddTest
//
//  Created by sunlight on 14-5-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#define kRowMenuSpace 20.0f
#define kColMenuSpace 20.0f
#define kGridRows 3
#define kGridCols 4
#define kPersistenceList @"ControllerList"
#define kPlistFileName @"plist"

#import <UIKit/UIKit.h>
#import "WsdMenuButton.h"

@interface RootViewController : UIViewController<UIScrollViewDelegate,WsdMenuButtonDelegate>

@property (nonatomic,strong) NSMutableArray *menuButtons;

- (void)saveSelectedControllerNames;

@end
