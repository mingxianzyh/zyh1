//
//  UserEntity.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "BaseEntity.h"

@interface UserEntity : BaseEntity

@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* passWord;
@property (nonatomic,strong) NSString* userCode;

+ (UserEntity*)shareLoginUser;

@end
