//
//  User.h
//  SupplierQuestionnaire
//
//  Created by sunlight on 14-6-18.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdBaseJastor.h"

@interface User : WsdBaseJastor

//用户名称
@property (nonatomic,copy) NSString *userName;
//用户代码
@property (nonatomic,copy) NSString *userCode;
//用户口令
@property (nonatomic,copy) NSString *pwd;
//域
@property (nonatomic,copy) NSString *domainCode;

@end
