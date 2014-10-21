//
//  MainControllerUtil.h
//  CustomAddTest
//
//  Created by sunlight on 14-5-14.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#define kControllerClassName1 @"ViewController1"
#define kControllerClassName2 @"ViewController2"
#define kControllerClassName3 @"ViewController1"

#import <Foundation/Foundation.h>

@interface MainControllerUtil : NSObject

//获取所有支持的菜单对象列表
+ (NSArray *)genAllSupportItemTitles;
//根据标题生产相应的视图控制器
+ (NSArray *)genViewControllersByClassNames:(NSArray *)classNames;
@end
