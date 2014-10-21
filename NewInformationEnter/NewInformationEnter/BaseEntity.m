//
//  BaseEntity.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-4.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

- (id)initWithId:(NSString *)id{
    self = [super init];
    if(self){
        _id = id;
    }
    return self;
}
@end
