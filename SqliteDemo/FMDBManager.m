//
//  FMDBManager.m
//  SqliteDemo
//
//  Created by sunlight on 14-3-27.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "FMDBManager.h"
@implementation FMDBManager

- (NSString *)path1{

    return [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/data.sqlite"];

}

- (NSString *)path2{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"data.sqlite"];

}

- (void)createTable{
    
    FMDatabase *dateBase = [self openDataBase];
    
    if(dateBase.open){
        [dateBase executeUpdate:@"create table if not exists testTable(column1 text,column2 text)"];
        [dateBase close];
    }

}

- (void)dropTable{
    //获取FMDB控制类
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path1];
    //打开数据库连接
    if([dataBase open]){
        //执行删除语句
        [dataBase executeUpdate:@"drop table testTable"];
        //关闭数据库连接
        [dataBase close];
    }
    
}

//管理数据(新增，删除，更新)--(建表与删表)
- (void)manageDataWithSql:(NSString*)sql params:(NSArray*) array{
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path1];
    if([dataBase open]){
        [dataBase executeUpdate:sql withArgumentsInArray:array];
    }
    [dataBase close];
}

//查询数据
- (void)selectDataWithSql:(NSString*)sql params:(NSArray*) array{

    FMDatabase *db = [FMDatabase databaseWithPath:self.path1];
    if([db open]){
        FMResultSet *rs= [db executeQuery:sql withArgumentsInArray:array];
        while ([rs next]) {
            NSString *username = [rs stringForColumn:@"username"];
            NSString *password = [rs stringForColumn:@"password"];
            int age = [rs intForColumn:@"age"];
            
            NSLog(@"username:%@,password:%@,age:%d",username,password,age);
        }
    }
    [db close];
}

- (FMDatabase *)openDataBase{
    return [FMDatabase databaseWithPath:self.path1];
}

    
@end
