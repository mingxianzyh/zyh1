//
//  CustomTabBarControllerViewController.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"
#import "DisasterViewController.h"
#import "ApplyFertilizerViewController.h"
#import "ApplyMedicineViewController.h"
#import "BirthViewController.h"
#import "SeedGrowViewController.h"
#import "TransPlantViewController.h"
#import "AgriCultureViewController.h"

#import "WeatherSelectViewController.h"

@interface CustomTabBarControllerViewController : UITabBarController<UISplitViewControllerDelegate>

//左边浮动窗口-在代理中赋值
@property (strong,nonatomic) UIPopoverController *popController;

//标记选择了哪一个tableCell
@property (assign,nonatomic) int index;

@property (strong,nonatomic) UIImageView *selectedBackgroudImage;

//录入导航控制器
@property (strong,nonatomic) UINavigationController *enterNavigationController;

//查询导航控制器
@property (strong,nonatomic) UINavigationController *selectNavigationController;

@end
