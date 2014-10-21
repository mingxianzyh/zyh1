//
//  WsdNetWorkUtil.h
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
//默认URL地址
#define defaultWebServiceUrl @"http://192.168.50.137:8080/partner/services/biz/bizJsonService.ws"

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SoapHelper.h"
#import "WsdServiceResponse.h"

@interface WsdNetWorkUtil : NSObject

//根据Soap字符串创建ASIHttpRequest对象
+ (ASIHTTPRequest *)genHttpRequestBySoapMessage:(NSString *)soapMessage AndServiceUrl:(NSString *)urlStr;

//根据请求的json与后台请求类名获取Soap Xml字符串()
+ (NSString *)genSoapMessageByRequestJson:(NSString *)requestJson AndBackgroundClassName:(NSString *)className;

//根据Soap返回消息返回response对象(解析接受json，返回response对象)
+ (NSDictionary *)genWsdServiceDictionaryByResponseSoapMessage:(NSString *)responseString;

@end
