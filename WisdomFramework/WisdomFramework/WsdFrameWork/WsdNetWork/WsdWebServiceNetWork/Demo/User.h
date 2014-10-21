//
//  User.h
//  JastorDemo
//
//  Created by sunlight on 14-5-7.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * pwd;
@property (nonatomic, retain) NSString * userCode;
@property (nonatomic, retain) NSString * userName;

@end
