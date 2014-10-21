//
//  WsdServiceResponse.h
//  JastorDemo
//
//  Created by sunlight on 14-5-8.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "Jastor.h"

//response响应父类
@interface WsdServiceResponse : Jastor

- (id)initWithResponseJson:(NSString *)responseJson AndResponseObjectClass:(Class) objClass;

//总行数
@property (nonatomic,assign) NSInteger totalCount;
//操作结果
@property (nonatomic,assign) BOOL result;
//返回结果对象
@property (nonatomic,strong) NSArray *responseObjects;
//responseObjects类型
@property (nonatomic,copy) Class responseObjects_class;

@end
