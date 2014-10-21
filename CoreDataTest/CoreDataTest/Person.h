//
//  Person.h
//  CoreDataTest
//
//  Created by sunlight on 14-4-24.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t age;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) Address *addressRelation;

@end
