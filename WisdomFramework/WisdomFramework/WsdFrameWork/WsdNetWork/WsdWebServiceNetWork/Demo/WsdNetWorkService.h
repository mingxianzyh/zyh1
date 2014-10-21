//
//  WsdNetWorkService.h
//  JastorDemo
//
//  Created by sunlight on 14-5-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

//用户请求对应后台类名
#define USERINFO_REQUEST @"com.wisdom.framework.system.webservice.basis.UserServiceRequest"
//用户查询后台方法
#define WSD_USER_QUERY @"query"

#import <Foundation/Foundation.h>
#import "WsdNetWorkUtil.h"

@interface WsdNetWorkService : NSObject
//分页查询
+ (void)queryUserInfoByPageNo:(NSInteger)pageNo AndPageSize:(NSInteger)pageSize AndDelegate:(id)delegate;

@end
