//
//  WSDStringUtils.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
//定义常量
#define WSD_NUMBERS @"0123456789"
#define WSD_DOUBLE_NUMBERS @"0123456789."
#define WSD_ZERO @"0"
#define WSD_DECIMAL_POINT @"."

#import <Foundation/Foundation.h>

//字符串工具类
@interface WsdStringUtils : NSObject

//判断是否字符串为空
+ (BOOL)isBlank:(NSString*)str;

//判断是否字符串不为空
+ (BOOL)isNotBlank:(NSString*)str;

//生成UUID
+ (NSString*)genUUID;

//判断字符串是否为整数
+ (BOOL)isNumber:(NSString*)str;

//判断字符串是否为小数
+ (BOOL)isDecialNumber:(NSString*)str;

//判断单字符串是否是数字类型(0123456789)
+ (BOOL)isMemeberOfNumber:(NSString*)singleStr;

//判断单字符串是否是小数类型(0123456789.)
+ (BOOL)isMemberOfDecialNumber:(NSString*)singleStr;

//获取ID集合
+ (NSArray *)listIdsByArray:(NSArray *)arrays;

//获取ID集合
+ (NSArray *)listIdsBySet:(NSSet *)set;

//判断两个字符串是否相等
+ (BOOL)isEqualString1:(NSString *)str1 WithString2:(NSString *)str2;

@end
