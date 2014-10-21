//
//  WeatherInfoEntity.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-4.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "BaseEntity.h"

//田间气象信息
@interface WeatherInfoEntity : BaseEntity

//年月
@property (nonatomic,strong) NSString* yearMonth;
//乡镇名称
@property (nonatomic,strong) NSString* townName;
//乡镇Id
@property (nonatomic,strong) NSString* townId;
//旬
@property (nonatomic,strong) NSString* partMonth;
//平均温度
@property (nonatomic,strong) NSNumber* avgTemp;
//平均日照数(小时)
@property (nonatomic,strong) NSNumber* avgSunHours;
//降水量(毫米)
@property (nonatomic,strong) NSNumber* rainFallAmount;
//平均相对温度
@property (nonatomic,strong) NSNumber* avgOppositeTemp;
//最高气温>=35度天数
@property (nonatomic,strong) NSNumber* hignTempDays;

@end
