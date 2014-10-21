//
//  WsdCommonUtil.h
//  WisdomFramework
//
//  Created by sunlight on 14-7-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WsdCommonUtil : NSObject

//数据相关
//判断字符串是否为int
+ (Boolean)isInt:(NSString *)string;
//判断字符串是否为float
+ (Boolean)isFloat:(NSString *)string;

//应用相关
//获取沙盒路径
+ (NSString *)getDocumentPath;

@end
