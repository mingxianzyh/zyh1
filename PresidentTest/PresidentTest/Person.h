//
//  Person.h
//  PresidentTest
//
//  Created by sunlight on 14-4-22.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding,NSCopying>

@property (copy,nonatomic) NSString* name;
@property (assign,nonatomic) int age;

@end
