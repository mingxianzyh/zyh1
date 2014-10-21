//
//  WsdServiceResponse.m
//  JastorDemo
//
//  Created by sunlight on 14-5-8.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdServiceResponse.h"
@implementation WsdServiceResponse

- (id)initWithResponseJson:(NSString *)responseJson AndResponseObjectClass:(Class) dtoClass{
    NSError *error;
    self.responseObjects_class = dtoClass;
    NSDictionary *dic=[responseJson objectFromJSONStringWithParseOptions:JKParseOptionValidFlags error:&error];
    if (self = [super initWithDictionary:dic]) {
        
    }
    return self;
}
@end
