//
//  FMDBManager.h
//  SqliteDemo
//
//  Created by sunlight on 14-3-27.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface FMDBManager : NSObject

- (NSString *)path1;

- (NSString *)path2;

- (void)createTable;

- (void)dropTable;

- (void)manageDataWithSql:(NSString*)sql params:(NSArray*) array;

- (void)selectDataWithSql:(NSString*)sql params:(NSArray*) array;

@end
