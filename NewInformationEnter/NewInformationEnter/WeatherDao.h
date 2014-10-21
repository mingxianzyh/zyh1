//
//  WeatherDao.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-10.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "WeatherInfoEntity.h"
#import "WSDStringUtils.h"

@interface WeatherDao : NSObject

//数据库主管理对象
@property (strong,nonatomic) FMDatabase *db;

- (DBResult)insertWeatherInfo:(WeatherInfoEntity *)weather;

- (DBResult)updateWeatherInfo:(WeatherInfoEntity *)weather;

- (DBResult)deleteWeatherInfo:(NSString *)id;

- (NSMutableArray*)queryAllWeatherInfo;

//分页查询
- (NSArray*)queryWeatherWithPageNum:(NSInteger)pageNum AndPageSize:(NSInteger)pageSize;
@end
