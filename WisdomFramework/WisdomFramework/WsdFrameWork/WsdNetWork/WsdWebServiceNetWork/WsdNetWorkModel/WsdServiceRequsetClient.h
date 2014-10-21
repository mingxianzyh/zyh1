//
//  WsdServiceRequsetClient.h
//  JastorDemo
//
//  Created by sunlight on 14-5-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#define WSD_USER_CODE @"admin"
#define WSD_USER_ID @"f78349a7-2b0c-4bba-8043-cede563b5b0c"
#define WSD_PASSWORD @"admin"
#define WSD_ORGCODE @"SHCO"
#define WSD_DOMAINCODE @"SHCO"

#import "Jastor.h"
#import <Foundation/Foundation.h>

//请求客户端信息类
@interface WsdServiceRequsetClient : Jastor

//客户端地址
@property (nonatomic,copy) NSString *ip;

//客户端类型
@property (nonatomic,copy) NSString *type;

//认证标志
@property (nonatomic,copy) NSString *userCode;

//用户名称
@property (nonatomic,copy) NSString *userName;

//用户标识
@property (nonatomic,copy) NSString *userId;

//当前组织
@property (nonatomic,copy) NSString *orgCode;

//当前业务组织
@property (nonatomic,copy) NSString *bizOrgCode;

//组织类型
@property (nonatomic,copy) NSString *bizOrgClass;

//域代码
@property (nonatomic,copy) NSString *domainCode;

//认证密码
@property (nonatomic,copy) NSString *password;

//密码加密算法
@property (nonatomic,copy) NSString *algorithm;
@end
