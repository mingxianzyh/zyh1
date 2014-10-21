//
//  WsdBeanUtil.h
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
//Dto 这三个字符串的长度
#define DTO_STRING_LENTH 3

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "WsdStringUtils.h"
#import "WsdArrayUtil.h"
#import "Jastor.h"

@interface WsdBeanUtil : NSObject

//po转换成dto
+ (id)converPoToDto:(id)po;

//po转换成dto(批量)
+ (NSArray *)converPosToDtos:(NSArray *)pos;

//po转换成dto(批量)
+ (NSSet *)converPosToDtosWithSet:(NSSet *)pos;

//dto转换成po(会同步到数据库)
+ (id)convertDtoToPo:(id)dto WithManagedContext:(NSManagedObjectContext*)context;

//dto转换成po(批量)(会同步到数据库)
+ (id)convertDtosToPos:(NSArray *)dtos WithManagedContext:(NSManagedObjectContext*)context;

//同步Dto到Po，并且保存,返回新增或修改的po(如果Dto的Id与Po的Id不一样，则会查询Dto相应的Id进行同步，并根据条件是否删除Po)
+ (id)synchroizePo:(id)po WithDto:(id)dto WithContext:(NSManagedObjectContext *)context isDeleteNotExistsPo:(BOOL)isDelete;

//批量同步Dto到Po
+ (NSArray *)synchroizePos:(NSArray *)pos AndDtos:(NSArray *)dtos WithContext:(NSManagedObjectContext *)context isDeleteNotExistsPo:(BOOL)isDelete;;

//批量同步Dto到Po
+ (NSSet *)synchroizeWithSetPos:(NSSet *)pos AndDtos:(NSSet *)dtos WithContext:(NSManagedObjectContext *)context isDeleteNotExistsPo:(BOOL)isDelete;


@end
