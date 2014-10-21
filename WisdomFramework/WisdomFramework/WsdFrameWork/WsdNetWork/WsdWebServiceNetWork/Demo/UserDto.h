//
//  UserDto.h
//  JastorDemo
//
//  Created by sunlight on 14-5-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "Jastor.h"

//传输对象
@interface UserDto : Jastor

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * userCode;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * pwd;

@end
