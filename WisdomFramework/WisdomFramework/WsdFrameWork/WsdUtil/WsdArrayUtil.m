//
//  WsdArrayUtil.m
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdArrayUtil.h"

@implementation WsdArrayUtil

//判断集合为空
+ (BOOL)isEmpty:(NSArray *)array{
    if (array == nil || [array count] == 0) {
        return YES;
    }else{
        return NO;
    }
}

//判断集合不为空
+ (BOOL)isNotEmpty:(NSArray *)array{
    if ([self isEmpty:array]) {
        return NO;
    }else{
        return YES;
    }
}

@end
