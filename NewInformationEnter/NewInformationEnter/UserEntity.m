//
//  UserEntity.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

//单例
+ (UserEntity*)shareLoginUser{
    static UserEntity* loginUser = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        
        loginUser = [[self alloc] init];
        
    });
    return loginUser;
}
@end
