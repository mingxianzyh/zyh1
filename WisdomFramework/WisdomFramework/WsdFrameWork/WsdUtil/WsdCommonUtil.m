//
//  WsdCommonUtil.m
//  WisdomFramework
//
//  Created by sunlight on 14-7-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdCommonUtil.h"
#import "WsdStringUtils.h"

@implementation WsdCommonUtil
//获取沙盒路径
+ (NSString *)getDocumentPath{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

//判断字符串是否为int
+ (Boolean)isInt:(NSString *)string{
    Boolean flag =  NO;
    if ([WsdStringUtils isNotBlank:string]) {
        NSScanner *scanner = [NSScanner scannerWithString:string];
        float val;
        flag = ([scanner scanFloat:&val] && [scanner isAtEnd]);
    }
    return flag;
}

//判断字符串是否为float
+ (Boolean)isFloat:(NSString *)string{
    Boolean flag =  NO;
    if ([WsdStringUtils isNotBlank:string]) {
        NSScanner *scanner = [NSScanner scannerWithString:string];
        float val;
        flag = ([scanner scanFloat:&val] && [scanner isAtEnd]);
    }
    return flag;
}

@end
