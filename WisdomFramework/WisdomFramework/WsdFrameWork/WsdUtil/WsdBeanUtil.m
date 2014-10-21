//
//  WsdBeanUtil.m
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdBeanUtil.h"

@implementation WsdBeanUtil
//获取对象的ID集合
+ (NSArray *)getIdsByObjs:(NSArray *)objs{
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if (objs != nil && [objs count] > 0) {
        for (id obj in objs) {
            NSString *pId = [obj objectForKey:@"id"];
            if (![WsdStringUtils isBlank:pId]) {
                [resultArray addObject:pId];
            }
        }
    }
    return resultArray;
}


//获取对象的属性
+ (NSArray *)getObjPropertities:(Class)objClass isCopyParent:(BOOL)isCopyParent;{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (objClass) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList(objClass, &count);
        for (int i = 0 ; i < count ;i ++) {
            objc_property_t property = properties[i];
            NSString *str=[[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [array addObject:str];
        }
        if (isCopyParent) {
            if (objClass != [NSObject class]) {
                NSArray *parentArray = [WsdBeanUtil getObjPropertities:[objClass superclass] isCopyParent:isCopyParent];
                if (parentArray && [parentArray count]>0) {
                    [array addObjectsFromArray:parentArray];
                }
            }
        }
        free(properties);
    }
    return array;
}
//获取对象的属性(class表示到哪一级别的父类)
+ (NSArray *)getObjPropertities:(Class)objClass parentClass:(Class)class1{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (objClass) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList(objClass, &count);
        for (int i = 0 ; i < count ;i ++) {
            objc_property_t property = properties[i];
            NSString *str=[[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [array addObject:str];
        }

        if ([objClass class] != class1) {
            NSArray *parentArray = [WsdBeanUtil getObjPropertities:[objClass superclass] parentClass:class1];
            if (parentArray && [parentArray count]>0) {
                [array addObjectsFromArray:parentArray];
            }
        }
        free(properties);
        
    }
    return array;
}


@end
