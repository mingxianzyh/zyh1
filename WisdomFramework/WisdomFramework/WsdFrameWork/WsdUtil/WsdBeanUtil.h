//
//  WsdBeanUtil.h
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "WsdStringUtils.h"
#import "WsdArrayUtil.h"

@interface WsdBeanUtil : NSObject

//获取对象的ID集合
+ (NSArray *)getIdsByObjs:(NSArray *)objs;

@end
