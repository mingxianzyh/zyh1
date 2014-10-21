//
//  PushNetwork.h
//  push
//
//  Created by sunlight on 14-5-30.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#define ServerUrl @"http://192.168.50.137:8080/Notice/push/"
#define ServerTokenAction @"push_%@Action"

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface PushNetwork : NSObject

+ (void)registerDevice:(NSString *)token;


@end
