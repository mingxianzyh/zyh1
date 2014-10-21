//
//  MainControllerUtil.m
//  CustomAddTest
//
//  Created by sunlight on 14-5-14.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainControllerUtil.h"
#import "WsdMenu.h"

@implementation MainControllerUtil

//获取所有支持的模块控制器列表
+ (NSArray *)genAllSupportItemTitles{
    
    NSMutableArray *arrays = [[NSMutableArray alloc] init];
    [arrays addObject:kControllerClassName1];
    [arrays addObject:kControllerClassName2];
    [arrays addObject:kControllerClassName3];
    return arrays;
}
//根据类名反射生产相应类
+ (NSArray *)genViewControllersByClassNames:(NSArray *)classNames{
    
    NSMutableArray *arrays = [[NSMutableArray alloc] init];
    for (NSString *className in classNames) {
        //反射获取类名
        Class controller = NSClassFromString(className);
        id obj = [[controller alloc] init];
        [arrays addObject:obj];
    }
    return arrays;
}

@end
