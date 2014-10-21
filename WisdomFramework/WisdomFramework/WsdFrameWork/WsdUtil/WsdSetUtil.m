//
//  WsdSetUtil.m
//  JastorDemo
//
//  Created by sunlight on 14-5-8.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdSetUtil.h"

@implementation WsdSetUtil

//判断集合为空
+ (BOOL)isEmpty:(NSSet *)set{
    if (set == nil || [set count] == 0) {
        return YES;
    }else{
        return NO;
    }
}

//判断集合不为空
+ (BOOL)isNotEmpty:(NSSet *)set{
    if ([self isEmpty:set]) {
        return NO;
    }else{
        return YES;
    }
}


@end
