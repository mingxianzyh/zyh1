//
//  WsdNetWorkUtil.m
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdNetWorkUtil.h"

@implementation WsdNetWorkUtil

//根据Soap字符串创建ASIHttpRequest对象
+ (ASIHTTPRequest *)genHttpRequestBySoapMessage:(NSString *)soapMessage{
    
    NSURL *url = [NSURL URLWithString:defaultWebServiceUrl];
    //调用init会出错，并且会少设置很多属性，不推荐使用init
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    //设置request属性
    [request addRequestHeader:@"Host" value:[url host]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",soapMessage.length]];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:30.0];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

//根据请求的json与后台请求类名(全名如:com.wisdom.system.XX)获取Soap Xml字符串
+ (NSString *)genSoapMessageByRequestJson:(NSString *)requestJson AndBackgroundClassName:(NSString *)className{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //后台约定节点requestClassName
    [dic setObject:className forKey:@"requestClassName"];
    //后台约定节点jsonRequest
    [dic setObject:requestJson forKey:@"jsonRequest"];
    
    //以上两个节点被包含在arg0节点中
    NSMutableDictionary *topDic = [NSMutableDictionary dictionaryWithObject:dic forKey:@"arg0"];
    NSMutableArray *array = [NSMutableArray arrayWithObject:topDic];
    
    NSString *soapMessage = [SoapHelper arrayToDefaultSoapMessage:array methodName:@"xfire"];
    return soapMessage;
}
+ (id)genWsdServiceResponseByResponseSoapMessage:(NSString *)responseString AndResponseObjectClass:(Class) objClass{
    
    WsdServiceResponse *response = nil;
    NSArray *array=[responseString componentsSeparatedByString:@"<jsonResponse>"];
    if (array.count>1) {
        NSArray *sonArray=[[array objectAtIndex:1] componentsSeparatedByString:@"</jsonResponse>"];
        NSString *responseJson=[[sonArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        response = [[WsdServiceResponse alloc] initWithResponseJson:responseJson AndResponseObjectClass:objClass];
        
    }
    return response;
}


@end
