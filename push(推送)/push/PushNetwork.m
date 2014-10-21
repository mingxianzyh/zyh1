//
//  PushNetwork.m
//  push
//
//  Created by sunlight on 14-5-30.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "PushNetwork.h"

@implementation PushNetwork

+ (void)registerDevice:(NSString *)token{
    
    NSURL *url = [NSURL URLWithString:[ServerUrl stringByAppendingString:[NSString stringWithFormat:ServerTokenAction,@"registerDevice"]]];
    
    NSString *postString = [NSString stringWithFormat:@"token=%@",token];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.shouldAttemptPersistentConnection = NO;
    //[request setValidatesSecureCertificate:NO];
    //设置requset头信息
    [request addRequestHeader:@"HOST" value:url.host];
    //[request addRequestHeader:@"Content-Type" value:@"text/xml;charset=utf-8"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%lu",(unsigned long)[postString length]]];
    
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:60.0f];
    //加入post数据
    [request appendPostData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    //[request setPostValue:token forKey:@"token"];
    NSLog(@"%@",[request postBody]);
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        NSLog(@"%@",error);
    }
}


@end
