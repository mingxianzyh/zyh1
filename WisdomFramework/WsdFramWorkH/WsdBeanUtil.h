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
#import "Jastor.h"

@interface WsdBeanUtil : NSObject

//获取对象的ID集合
+ (NSArray *)getIdsByObjs:(NSArray *)objs;
//获取对象的属性
+ (NSArray *)getObjPropertities:(Class)objClass isCopyParent:(BOOL)isCopyParent;

//获取对象的属性(class表示到哪一级别的父类)
+ (NSArray *)getObjPropertities:(Class)objClass parentClass:(Class)class1;
@end
