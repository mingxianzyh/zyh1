//
//  Address.h
//  CoreDataTest
//
//  Created by sunlight on 14-4-24.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;

@end
