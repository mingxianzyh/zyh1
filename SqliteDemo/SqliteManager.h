//
//  SqliteManager.h
//  SqliteDemo
//
//  Created by sunlight on 14-3-27.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SqliteManager : NSObject

- (void)createUserTable;

- (void)createOrgTable;

- (void)insertUserInfo;

- (void)insertOrgInfo;

- (void)queryUserInfo;

- (void)queryOrgInfo;

- (void)deleteUserInto;

- (void)deleteOrgInfo;

- (void)updateUserInfo;

- (void)updateOrgInfo;

@end
