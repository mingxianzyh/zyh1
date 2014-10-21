//
//  WsdNetWorkService.m
//  JastorDemo
//
//  Created by sunlight on 14-5-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdNetWorkService.h"
#import "WsdServiceRequsetClient.h"
#import "WsdServiceRequest.h"
#import "UserDto.h"
#import "SoapHelper.h"
#import "ASIHTTPRequest.h"

@implementation WsdNetWorkService

//分页查询
+ (void)queryUserInfoByPageNo:(NSInteger)pageNo AndPageSize:(NSInteger)pageSize AndDelegate:(id)delegate{
    //构建request对象
    WsdServiceRequsetClient *client = [[WsdServiceRequsetClient alloc] init];
    WsdServiceRequest *userRequest = [[WsdServiceRequest alloc] init];
    userRequest.client = client;
    userRequest.method = WSD_USER_QUERY;
    userRequest.pageNo = pageNo;
    userRequest.pageSize = pageSize;
    
//    UserDto *userDto = [[UserDto alloc] init];
//    userDto.userCode = WSD_USER_CODE;
//    userRequest.queryObject = userDto;
    
    //获取请求的request信息
    NSString *requestJson = [userRequest toJson];
    NSLog(@"%@",requestJson);
    
    NSString *soapMessage = [WsdNetWorkUtil genSoapMessageByRequestJson:requestJson AndBackgroundClassName:USERINFO_REQUEST];
    NSLog(@"%@",soapMessage);
    /*
    ASIHTTPRequest *request = [WsdNetWorkUtil genHttpRequestBySoapMessage:soapMessage];
     */
    //设置代理
//    request.delegate = delegate;
//    [request startAsynchronous];
}


@end
