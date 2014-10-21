//
//  WeatherDao.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-10.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WeatherDao.h"

@implementation WeatherDao

- (id)init{
    
    self = [super init];
    if(self){
        [self createTable];
    }
    return self;
}

- (NSString *)genDatabasePath{
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *allPath = [path stringByAppendingPathComponent:@"info.sqlite"];
    return allPath;
}

//创建表格
- (DBResult)createTable{
    
    //获取数据库
    if (!_db) {
        _db = [FMDatabase databaseWithPath:[self genDatabasePath]];
        [_db setShouldCacheStatements:YES];
    }
    
    if (![_db open]) {
        NSLog(@"打开数据库失败");
        return DBResultOpenDatabaseFailure;
    }
    if (![_db tableExists:@"weather_info"]) {
        //创建新表
        [_db executeUpdate:@"create table weather_info (id varchar(36) primary key,orgId varchar(36),orgCode varchar(36),orgName varchar(36),createDate text,updateDate text,yearMonth varchar(36),townName varchar(36),townId varchar(36),partMonth varchar(36),avgTemp double,avgSunHours double,rainFallAmount double,avgOppositeTemp double,hignTempDays integer)"];
    }
    [_db close];
    return DBResultSuccess;
}

//插入天气数据
- (DBResult)insertWeatherInfo:(WeatherInfoEntity *)weather{
    
    DBResult result = DBResultSuccess;
    //获取数据库
    if (!_db) {
        _db = [FMDatabase databaseWithPath:[self genDatabasePath]];
        [_db setShouldCacheStatements:YES];
    }
    if (![_db open]) {
        NSLog(@"打开数据库失败");
        return DBResultOpenDatabaseFailure;
    }
    //判断当前年月旬以及乡镇的信息是否存在
    FMResultSet *resultSet = [_db executeQuery:@"select count(*) from weather_info where yearMonth = ? and partMonth = ? and townName = ?",weather.yearMonth,weather.partMonth,weather.townName];
    if (resultSet) {
        [resultSet next];
        int count = [resultSet intForColumnIndex:0];
        [resultSet close];
        //判断信息是否存在
        if (count>0) {
            result = DBResultDataHasExists;
        }else{
        //不存在则插入
            weather.id = [WSDStringUtils genUUID];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:weather.id];
            if (weather.orgId) {
             [array addObject:weather.orgId];
            }else{
             [array addObject:[NSNull null]];
            }
            if (weather.orgCode) {
                [array addObject:weather.orgCode];
            }else{
                [array addObject:[NSNull null]];
            }
            if (weather.orgName) {
                [array addObject:weather.orgName];
            }else{
                [array addObject:[NSNull null]];
            }
            [array addObject:weather.createDate];
            [array addObject:weather.updateDate];
            [array addObject:weather.yearMonth];
            [array addObject:weather.townName];
            if (weather.townId) {
                [array addObject:weather.townId];
            }else{
                [array addObject:[NSNull null]];
            }
            [array addObject:weather.partMonth];
            [array addObject:weather.avgTemp];
            [array addObject:weather.avgSunHours];
            [array addObject:weather.rainFallAmount];
            [array addObject:weather.avgOppositeTemp];
            [array addObject:weather.hignTempDays];
            [_db executeUpdate:@"insert into weather_info (id,orgId,orgCode,orgName,createDate,updateDate,yearMonth,townName,townId,partMonth,avgTemp,avgSunHours,rainFallAmount,avgOppositeTemp,hignTempDays) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" withArgumentsInArray:array];
        }
    }
    
    [_db close];
    return result;
}
//插入
- (DBResult)updateWeatherInfo:(WeatherInfoEntity *)weather{
    
    return DBResultSuccess;
}

- (DBResult)deleteWeatherInfo:(NSString *)id{
    
    if(!_db){
        _db = [FMDatabase databaseWithPath:[self genDatabasePath]];
        [_db setShouldCacheStatements:YES];
    }
    if(![_db open]){
        NSLog(@"打开数据库失败");
        return DBResultOpenDatabaseFailure;
    }
    [_db executeUpdate:@"delete weather_info where id = ?",id];
    [_db close];
    return DBResultSuccess;
}

- (NSMutableArray*)queryAllWeatherInfo{
    
    if (!_db) {
        _db = [FMDatabase databaseWithPath:[self genDatabasePath]];
        [_db setShouldCacheStatements:YES];
    }
    if (![_db open]) {
        NSLog(@"打开数据库失败");
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    WeatherInfoEntity *entity;
    FMResultSet *resultSet = [_db executeQuery:@"select * from weather_info"];
    if (resultSet) {
        while ([resultSet next]) {
            entity = [[WeatherInfoEntity alloc] init];
            NSString *id = [resultSet stringForColumn:@"id"];
            entity.id = id;
            NSString *orgId = [resultSet stringForColumn:@"orgId"];
            entity.orgId = orgId;
            NSString *orgCode = [resultSet stringForColumn:@"orgCode"];
            entity.orgCode = orgCode;
            NSString *orgName = [resultSet stringForColumn:@"orgName"];
            entity.orgName = orgName;
            NSDate *createDate = [resultSet dateForColumn:@"createDate"];
            entity.createDate = createDate;
            NSDate *updateDate = [resultSet dateForColumn:@"updateDate"];
            entity.updateDate = updateDate;
            NSString *yearMonth = [resultSet stringForColumn:@"yearMonth"];
            entity.yearMonth = yearMonth;
            NSString *townName = [resultSet stringForColumn:@"townName"];
            entity.townName = townName;
            NSString *townId = [resultSet stringForColumn:@"townId"];
            entity.townId = townId;
            NSString *partMonth = [resultSet stringForColumn:@"partMonth"];
            entity.partMonth = partMonth;
            double avgTemp = [resultSet doubleForColumn:@"avgTemp"];
            entity.avgTemp = [NSNumber numberWithDouble:avgTemp];
            double avgSunHours = [resultSet doubleForColumn:@"avgSunHours"];
            entity.avgSunHours = [NSNumber numberWithDouble:avgSunHours];
            double rainFallAmount = [resultSet doubleForColumn:@"rainFallAmount"];
            entity.rainFallAmount = [NSNumber numberWithDouble:rainFallAmount];
            double avgOppositeTemp = [resultSet doubleForColumn:@"avgOppositeTemp"];
            entity.avgOppositeTemp = [NSNumber numberWithDouble:avgOppositeTemp];
            int hignTempDays = [resultSet doubleForColumn:@"hignTempDays"];
            entity.hignTempDays = [NSNumber numberWithInt:hignTempDays];
            [array addObject:entity];
        }
    }
    return array;
}

//分页查询
- (NSArray*)queryWeatherWithPageNum:(NSInteger)pageNum AndPageSize:(NSInteger)pageSize{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    return result;
}


@end
