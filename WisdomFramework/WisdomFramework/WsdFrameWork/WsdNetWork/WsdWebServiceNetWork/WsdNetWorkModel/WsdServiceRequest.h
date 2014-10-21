//
//  WsdServiceRequest.h
//  JastorDemo
//
//  Created by sunlight on 14-5-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdServiceRequsetClient.h"
//webservice请求父类
@interface WsdServiceRequest : Jastor

//请求客户端
@property (nonatomic,strong) WsdServiceRequsetClient *client;
//请求方法名称
@property (nonatomic,copy) NSString *method;

@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic,assign) NSInteger pageNo;

//查询条件对象
@property (nonatomic,strong) id queryObject;
//非查询对象
@property (nonatomic,strong) NSArray *requestObjects;

@end
