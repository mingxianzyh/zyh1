//
//  WsdBeanUtil.m
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <CoreData/CoreData.h>//>
#import "WsdBeanUtil.h"

@implementation WsdBeanUtil


//根据PO对象获取相应Dto类名
+ (NSString *)genDtoClassNameByPo:(id)po{
    
    Class class = [po class];
    NSString *poName = [[NSString alloc] initWithCString:class_getName(class) encoding:NSUTF8StringEncoding];
    return [poName stringByAppendingString:@"Dto"];
}

+ (NSString *)genPoClassNameByDto:(id)dto{

    Class class = [dto class];
    NSString *dtoName = [[NSString alloc] initWithCString:class_getName(class) encoding:NSUTF8StringEncoding];
    //Dto约定在末尾，只有Dto三个字符
    return [dtoName substringToIndex:[dtoName length]-DTO_STRING_LENTH];
}

//po转换成dto
+ (id)converPoToDto:(id)po{
    
    //获取Dto对象
    Class dtoClass = NSClassFromString([self genDtoClassNameByPo:po]);
    //获取dto对象
    id dto = [[dtoClass alloc] init];
    //获取dto属性列表
    unsigned int count ;
    //获取属性列表(结构体)
    objc_property_t *properties = class_copyPropertyList(dtoClass, &count);
    if (count > 0) {
        for (int i = 0 ; i < count; i++) {
            objc_property_t property = properties[i];
            //获取属性名称
            NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if ([po respondsToSelector:NSSelectorFromString(key)]) {
                id value =  [po valueForKey:key];
                //如果是持久化对象(则需要再次调用当前方法处理)
                if ([value isKindOfClass:[NSManagedObject class]]) {
                    id valueDto = [self converPoToDto:value];
                    [dto setValue:valueDto forKey:key];
                }else if([value isKindOfClass:[NSArray class]]){
                    //调用批量转换
                    NSArray *valueDtos = [self converPosToDtos:value];
                    [dto setValue:valueDtos forKey:key];
                }else if([value isKindOfClass:[NSSet class]]){
                    NSSet *valueDtos = [self converPosToDtosWithSet:value];
                    [dto setValue:valueDtos forKey:key];
                }else if([value isKindOfClass:[NSDictionary class]]){
                //字典类型的直接赋值(后期实现复杂的处理)
                    [dto setValue:value forKey:key];
                }else{
                    //其他类型直接赋值
                    [dto setValue:value forKey:key];
                }
            }
        }
        free(properties);
    }
    return  dto;
}
//po转换成dto(批量)
+ (NSSet *)converPosToDtosWithSet:(NSSet *)pos{
    NSMutableSet *dtos = nil;
    if (pos!=nil&&[pos count]>0) {
        for (id po in pos) {
            id dto = nil;
            //如果是持久化对象(则需要再次调用当前方法处理)
            if ([po isKindOfClass:[NSManagedObject class]]) {
                dto = [self converPoToDto:po];
            }else if([po isKindOfClass:[NSArray class]]){
                //调用批量转换
                dto = [self converPosToDtos:po];
            }else if([po isKindOfClass:[NSSet class]]){
                dto = [self converPosToDtosWithSet:po];
            }else if([po isKindOfClass:[NSDictionary class]]){
                //字典类型的直接赋值(后期实现复杂的处理)
                dto = po;
            }else{
                //其他类型直接赋值
                dto = po;
            }
            [dtos addObject:dto];
        }
    }
    return dtos;
}
//po转换成dto(批量)
+ (NSArray *)converPosToDtos:(NSArray *)pos{
    
    NSMutableArray *dtos = nil;
    if (pos!=nil&&[pos count]>0) {
        for (int i = 0; i < [pos count]; i++) {
            id po = pos[i];
            id dto = nil;
            //如果是持久化对象(则需要再次调用当前方法处理)
            if ([po isKindOfClass:[NSManagedObject class]]) {
                dto = [self converPoToDto:po];
            }else if([po isKindOfClass:[NSArray class]]){
                //调用批量转换
                dto = [self converPosToDtos:po];
            }else if([po isKindOfClass:[NSSet class]]){
                dto = [self converPosToDtosWithSet:po];
            }else if([po isKindOfClass:[NSDictionary class]]){
                //字典类型的直接赋值(后期实现复杂的处理)
                dto = po;
            }else{
                //其他类型直接赋值
                dto = po;
            }
            [dtos addObject:dto];
        }
    }
    return dtos;
}
//dto转换成po
+ (id)convertDtoToPo:(id)dto WithManagedContext:(NSManagedObjectContext*)context{
    //调用批量实现
    NSArray *dtos = [NSArray arrayWithObject:dto];
    return [[self convertDtosToPos:dtos WithManagedContext:context] lastObject];
}
//dto转换成po(批量)
+ (NSArray *)convertDtosToPos:(NSArray *)dtos WithManagedContext:(NSManagedObjectContext*)context;{
    //获取po的类名
    NSString *poName = [self genPoClassNameByDto:[dtos lastObject]];
    NSMutableArray *pos = [[NSMutableArray alloc] init];
    NSArray *ids = [WsdStringUtils listIdsByArray:dtos];
    
    //获取coreData上下文
//    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    if ([WsdArrayUtil isNotEmpty:ids]) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:poName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id in %@",ids];
        request.predicate = predicate;
        NSError *error;
        NSArray *array = [context executeFetchRequest:request error:&error];
        NSLog(@"%@",error);
        //字典存放id与相应的对象
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if ([WsdArrayUtil isNotEmpty:array]) {
            for (int i = 0 ; i < [array count]; i++) {
                [dic setObject:array[i] forKey:[array[i] valueForKey:@"id"]];
            }
        }
        //循环Dto判断是否存在相应ID的数据
        for (id dto in dtos) {
            NSString *idValue = [dto valueForKey:@"id"];
            id po = nil;
            if ([WsdStringUtils isNotBlank:idValue]&&[dic objectForKey:idValue]!=nil) {
                po = [dic objectForKey:idValue];
            }else{
                //如果不存在，则需要新增一个持久化对象
                po = [NSEntityDescription insertNewObjectForEntityForName:poName inManagedObjectContext:context];
            }
            //同步Po
            po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
            [pos addObject:po];
        }
    }else{
        for (id dto in dtos) {
            id po = [NSEntityDescription insertNewObjectForEntityForName:poName inManagedObjectContext:context];
            //同步Po
            po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
            [pos addObject:po];
        }
    }
    return pos;
}
//批量同步
+ (NSArray *)synchroizePos:(NSArray *)pos AndDtos:(NSArray *)dtos WithContext:(NSManagedObjectContext *)context isDeleteNotExistsPo:(BOOL)isDelete;{
    NSError *error;
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if (pos == nil) {
        for (id dto in dtos) {
            id po ;
            //查询当前Dto对应的po是否存在
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self genPoClassNameByDto:dto]];
            NSString *dtoId = [dto valueForKey:@"id"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",dtoId];
            
            request.predicate = predicate;
            NSArray *results = [context executeFetchRequest:request error:&error];
            if (results!=nil&&[results count]>0) {
                //存在则同步数据库中po
                po = [results lastObject];
            }else{
                //不存在新增
                po = [NSEntityDescription insertNewObjectForEntityForName:[self genPoClassNameByDto:dto] inManagedObjectContext:context];
            }
            po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
            [resultArray addObject:po];
        }
    }else{
        //po ID与实体字典
        NSMutableDictionary *poDic = [[NSMutableDictionary alloc] init];
        for (id po in pos) {
            [poDic setObject:pos forKey:[po valueForKey:@"id"]];
        }
        //循环处理Dto
        for (id dto in dtos) {
            NSString *dtoId = [dto valueForKey:@"id"];
            id po =[poDic valueForKey:dtoId];
            //如果相应dto的ID在pos中不存在，则判断该ID在数据库是否存在，存在则使用此po进行同步，否则新增
            if (po == nil) {
                //查询coreData
                NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([po class])];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",[dto valueForKey:@"id"]];
                request.predicate = predicate;
                NSArray *results = [context executeFetchRequest:request error:&error];
                if (results!=nil&&[results count]>0) {
                    po = [results lastObject];
                }else{
                    po = [NSEntityDescription insertNewObjectForEntityForName:[self genPoClassNameByDto:dto] inManagedObjectContext:context];
                }
                po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
                [resultArray addObject:po];
            }else{
                //如果相应ID在Pos中存在，直接同步
                po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
                [resultArray addObject:po];
                //移除字典中已处理的po
                [poDic removeObjectForKey:dtoId];
            }
        }
        if (isDelete) {
            if ([poDic count]>0) {
                NSArray *array = [poDic allValues];
                for (id po in array) {
                    [context delete:po];
                }
            }
        }
    }
    [context save:&error];
    if (error!=nil) {
        NSLog(@"%@",error);
    }
    return resultArray;
}
//批量同步Dto到Po，并且保存
+ (NSSet *)synchroizeWithSetPos:(NSSet *)pos AndDtos:(NSSet *)dtos WithContext:(NSManagedObjectContext *)context isDeleteNotExistsPo:(BOOL)isDelete{
    NSError *error;
    NSMutableSet *resultSet = [[NSMutableSet alloc] init];
    if (pos == nil) {
        for (id dto in dtos) {
            id po = [NSEntityDescription insertNewObjectForEntityForName:[self genPoClassNameByDto:dto] inManagedObjectContext:context];
            po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
            [resultSet addObject:po];
        }
    }else{
        //po ID与实体字典
        NSMutableDictionary *poDic = [[NSMutableDictionary alloc] init];
        for (id po in pos) {
            [poDic setObject:pos forKey:[po valueForKey:@"id"]];
        }
        //循环处理Dto
        for (id dto in dtos) {
            NSString *dtoId = [dto valueForKey:@"id"];
            id po =[poDic valueForKey:dtoId];
            //如果相应dto的ID在pos中不存在，则判断该ID在数据库是否存在，存在则使用此po进行同步，否则新增
            if (po == nil) {
                //查询coreData
                NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([po class])];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",[dto valueForKey:@"id"]];
                request.predicate = predicate;
                NSArray *results = [context executeFetchRequest:request error:&error];
                if (results!=nil&&[results count]>0) {
                    po = [results lastObject];
                }else{
                    po = [NSEntityDescription insertNewObjectForEntityForName:[self genPoClassNameByDto:dto] inManagedObjectContext:context];
                }
                
                po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
                [resultSet addObject:po];
            }else{
            //如果相应ID在Pos中存在，直接同步
                po = [self synchroizePo:po WithDto:dto WithContext:context isDeleteNotExistsPo:NO];
                [resultSet addObject:po];
                //移除字典中已处理的po
                [poDic removeObjectForKey:dtoId];
            }
        }
        if (isDelete) {
            if ([poDic count]>0) {
                NSArray *array = [poDic allValues];
                for (id po in array) {
                    [context delete:po];
                }
            }
        }
    }
    [context save:&error];
    if (error!=nil) {
        NSLog(@"%@",error);
    }
    return resultSet;
}
//同步Dto到Po，并且保存
+ (id)synchroizePo:(id)po WithDto:(id)dto WithContext:(NSManagedObjectContext *)context isDeleteNotExistsPo:(BOOL)isDelete{
    NSError *error;
    //如果po为nil，则新增
    if (po==nil) {
        po = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([po class]) inManagedObjectContext:context];
    }else{
        //处理持久化对象的po与dto的ID不相等的情况
        if ([WsdStringUtils isNotBlank:[po valueForKey:@"id"]]&&![WsdStringUtils isEqualString1:[po valueForKey:@"id"] WithString2:[dto valueForKey:@"id"]]) {
            if (isDelete) {
                [context delete:po];
            }
            //取dto的ID进行查询，不存在新增，存在则同步
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self genPoClassNameByDto:dto]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",[dto valueForKey:@"id"]];
            request.predicate = predicate;
            NSArray *results = [context executeFetchRequest:request error:&error];
            if ([WsdArrayUtil isNotEmpty:results]) {
                po = [results lastObject];
            }else{
                po = [NSEntityDescription insertNewObjectForEntityForName:[self genPoClassNameByDto:dto] inManagedObjectContext:context];
            }
        }
    }
    //获取dto属性列表
    unsigned int count ;
    //获取属性列表(结构体)
    objc_property_t *properties = class_copyPropertyList([po class], &count);
    for (int i = 0 ; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //从Dto中获取值
        id dtoValue = [dto valueForKey:key];
        if (dtoValue != nil) {
            //如果dto的属性属性Jastor类型，说明po中相应的属性是持久化对象，也需要同步
            if([dtoValue isKindOfClass:[Jastor class]]){
                id poValue = [po valueForKey:key];
                //属性替换不进行删除操作
                poValue = [self synchroizePo:poValue WithDto:dtoValue WithContext:context isDeleteNotExistsPo:NO];
                [po setValue:poValue forKeyPath:key];
            }else if([dtoValue isKindOfClass:[NSArray class]]) {
                NSArray *poValues = [po valueForKey:key];
                [self synchroizePos:poValues AndDtos:dtoValue WithContext:context isDeleteNotExistsPo:NO];
            }else if([dtoValue isKindOfClass:[NSSet class]]){
                NSSet *poValues = [po valueForKey:key];
                [self synchroizeWithSetPos:poValues AndDtos:dtoValue WithContext:context isDeleteNotExistsPo:NO];
            }else if([dtoValue isKindOfClass:[NSDictionary class]]){
                //字典类型暂时不处理，直接赋值
                [po setValue:dtoValue forKeyPath:key];
            }else{
                [po setValue:dtoValue forKeyPath:key];
            }
        }else{
            [po setValue:nil forKey:key];
        }
    }
    free(properties);
    [context save:&error];
    return po;
}
@end
