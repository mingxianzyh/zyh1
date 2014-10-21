//
//  WsdBaseJastor.h
//  WisdomFramework
//
//  Created by sunlight on 14-8-12.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "Jastor.h"

@interface WsdBaseJastor : Jastor

//id
@property (nonatomic,copy) NSString *id;
//公司
@property (nonatomic,copy) NSString *orgCode;
//业务组织
@property (nonatomic,copy) NSString *bizOrgCode;

@property (nonatomic,strong) id obj1;
@property (nonatomic,strong) id obj2;
@property (nonatomic,strong) id obj3;

@end
