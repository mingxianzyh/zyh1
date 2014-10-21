//
//  SqliteManager.m
//  SqliteDemo
//
//  Created by sunlight on 14-3-27.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "SqliteManager.h"

struct student {
    int age;
};
typedef struct student *student;

@implementation SqliteManager

- (void)createUserTable{
    
    //不透明类型->结构体指针
    sqlite3 *sqlite;
    //定义数据库文件路径
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",@"data.sqlite"];
    //打开数据库，如果不存在则创建
    int result = sqlite3_open([path UTF8String], &sqlite);
    if(result != SQLITE_OK){
        NSLog(@"open failure");
        return;
    }
    NSString *sql = @"create table if not exists user (username text primary key,password text,age Integer)";
    char *error;
    //执行创建语句
    result = sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &error);
    if(result != SQLITE_OK){
        NSLog(@"create failure");
        return;
    }
    //关闭数据库连接
    sqlite3_close(sqlite);
    NSLog(@"success");
}

- (void)createOrgTable{
    
    sqlite3 *sqlite;
    NSString *dataPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",@"data.sqlite"];
    NSLog(@"%@",dataPath);
    //打开数据库
    int result = sqlite3_open([dataPath UTF8String], &sqlite);
    if(result!=SQLITE_OK){
        NSLog(@"open failure");
        return;
    }
    NSString *sql = @"create table if not exists org_info(id varchar(36) primary key,orgcode varchar(36),orgName varchar(36))";
    //执行ddl
    char *error;
    result = sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL,&error);
    if(result!=SQLITE_OK){
        NSLog(@"create failue");
        return;
    }
    //关闭数据库
    sqlite3_close(sqlite);
    NSLog(@"exec success");
}

- (void)insertUserInfo{

    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    //获取数据库目录
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",@"data.sqlite"];
    //打开数据库
    int result = sqlite3_open([path UTF8String], &sqlite);
    if(result!=SQLITE_OK){
        NSLog(@"open database failure");
        return ;
    }
    //定义执行的sql语句
    NSString *sql = @"insert or replace into user values(?,?,?)";
    //预编译sql语句
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    //绑定字段
    sqlite3_bind_text(stmt, 1, [@"zhangsan" UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [@"zhangsan" UTF8String], -1, NULL);
    sqlite3_bind_int(stmt,3,5);
    
    //执行
    result = sqlite3_step(stmt);
    if(result == SQLITE_ERROR || result == SQLITE_MISUSE){
        NSLog(@"step failure");
        return;
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
}

- (void)insertOrgInfo{
    
    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    sqlite3_open([path UTF8String], &sqlite);
    
    NSString *sql = @"insert into org_info values(?,?,?)";
    //预编码sql语句
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    //设置字段
    sqlite3_bind_text(stmt, 1, [@"1" UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [@"SHJY" UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 3, [@"上海卷烟厂" UTF8String], -1, NULL);
    //执行语句
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    

}

- (void)queryUserInfo{
    
    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    int result = sqlite3_open([path UTF8String], &sqlite);
    if(result != SQLITE_OK){
        NSLog(@"open failuer");
        return;
    }
    NSString *sql = @"select username,password,age from user where age > ?";
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    
    sqlite3_bind_int(stmt, 1, 0);
    
    result = sqlite3_step(stmt);
    while(result == SQLITE_ROW){
        
        char *username = (char *)sqlite3_column_text(stmt, 0);
        char *password = (char *)sqlite3_column_text(stmt, 1);
        int age = sqlite3_column_int(stmt, 2);
        
        NSString *username1 = [NSString stringWithCString:username encoding:NSUTF8StringEncoding];
        NSString *password1 = [NSString stringWithCString:password encoding:NSUTF8StringEncoding];
        NSLog(@"name:%@,pwd:%@,age:%d",username1,password1,age);
        
        result = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
}

- (void)queryOrgInfo{
    
    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    sqlite3_open([path UTF8String], &sqlite);
    
    NSString *sql = @"select orgCode,orgName from org_info ";
    //预编译sql
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    //执行一步sql
    int result = sqlite3_step(stmt);
    while(result == SQLITE_ROW){
        char *orgCode = (char *)sqlite3_column_text(stmt, 0);
        char *orgName = (char *)sqlite3_column_text(stmt, 1);
        
        NSString *orgCode1 = [NSString stringWithCString:orgCode encoding:NSUTF8StringEncoding];
        NSString *orgName1 = [NSString stringWithCString:orgName encoding:NSUTF8StringEncoding];
        NSLog(@"code:%@,name:%@",orgCode1,orgName1);
        result = sqlite3_step(stmt);
    }
    //释放句柄
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
}

- (void)deleteUserInto{
    
    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    sqlite3_open([path UTF8String], &sqlite);
    
    NSString *sql = @"delete from user where username = ?";
    //预编码sql语句
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    //设置字段
    sqlite3_bind_text(stmt, 1, [@"zhangsan" UTF8String], -1, NULL);
    //执行语句
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
}

- (void)deleteOrgInfo{

}

- (void)updateUserInfo{
    
    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    sqlite3_open([path UTF8String], &sqlite);
    
    NSString *sql = @"update user set password = ? where username = ?";
    //预编码sql语句
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    //设置字段
    sqlite3_bind_text(stmt, 1, [@"123456" UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [@"zhangsan" UTF8String], -1, NULL);
    //执行语句
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
}

- (void)updateOrgInfo{
    
    sqlite3 *sqlite;
    sqlite3_stmt *stmt;
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    sqlite3_open([path UTF8String], &sqlite);
    
    NSString *sql = @"update org_info set orgCode = ? where id = ?";
    //预编码sql语句
    sqlite3_prepare(sqlite, [sql UTF8String], -1, &stmt, NULL);
    //设置字段
    sqlite3_bind_text(stmt, 1, [@"SHCO" UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [@"1" UTF8String], -1, NULL);
    //执行语句
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
}

@end
