//
//  WsdServiceRequsetClient.m
//  JastorDemo
//
//  Created by sunlight on 14-5-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdServiceRequsetClient.h"

@implementation WsdServiceRequsetClient
@synthesize ip,algorithm,bizOrgClass,bizOrgCode,domainCode,orgCode,password,type,userCode,userName,userId;

- (id)init{

    if (self = [super init]) {
        self.userId = WSD_USER_ID;
        self.userCode = WSD_USER_CODE;
        self.password = WSD_PASSWORD;
        self.orgCode = WSD_ORGCODE;
        self.domainCode = WSD_DOMAINCODE;
    }
    return self;
}

@end
