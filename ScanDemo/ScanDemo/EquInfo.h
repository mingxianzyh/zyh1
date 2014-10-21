//
//  EquInfo.h
//  ScanDemo
//
//  Created by sunlight on 14-9-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquInfo : NSObject
//唯一标识
@property (nonatomic,strong) NSString *id;
//手机号码 目前无法获取
@property (nonatomic,strong) NSString *mobileNo;
//IMEI 目前无法获取
@property (nonatomic,strong) NSString *imei;
//二维条码信息
@property (nonatomic,strong) NSString *qriInfo;
//扫描时间
@property (nonatomic,strong) NSDate *scanTime;
//东经
@property (nonatomic,assign) float longitude;
//北纬
@property (nonatomic,assign) float latitude;
//精度
@property (nonatomic,assign) float accuracy;
//水平精度
@property (nonatomic,assign) float lop;
//垂直精度
@property (nonatomic,assign) float va;
//水平高度
@property (nonatomic,assign) float lh;
//地理位置获取时间
@property (nonatomic,assign) NSDate *getLocationTime;
@end
