//
//  BaseEntity.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-4.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject

@property (strong,nonatomic) NSString* id;

@property (strong,nonatomic) NSString* orgId;

@property (strong,nonatomic) NSString* orgCode;

@property (strong,nonatomic) NSString* orgName;

@property (strong,nonatomic) NSDate* createDate;

@property (strong,nonatomic) NSDate* updateDate;

- (id)initWithId:(NSString *)id;

@end
