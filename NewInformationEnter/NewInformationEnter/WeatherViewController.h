//
//  WeatherViewController.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDao.h"
#import "WSDStringUtils.h"
#import "WeatherInfoEntity.h"
#import "UserEntity.h"
#import "CustomPickerView.h"
#import "ZSYPopoverListView.h"
#import "ContentViewController.h"

//田间气象信息
@interface WeatherViewController : ContentViewController<CustomPickerDelegate,UITextFieldDelegate,ZSYPopoverListDelegate,ZSYPopoverListDatasource>

//数据交互接口
@property (nonatomic,strong) WeatherDao *weatherDao;
//当前页面存储对象
@property (nonatomic,strong) WeatherInfoEntity *weatherInfo;
//选择年月对象
@property (nonatomic,strong) CustomPickerView *pickView;

@property (strong, nonatomic) IBOutlet UITextField *yearMonth;
@property (strong, nonatomic) IBOutlet UITextField *townName;
@property (strong, nonatomic) IBOutlet UITextField *partMonth;
@property (strong, nonatomic) IBOutlet UITextField *avgTemp;
@property (strong, nonatomic) IBOutlet UITextField *avgSunHours;
@property (strong, nonatomic) IBOutlet UITextField *rainFallAmount;
@property (strong, nonatomic) IBOutlet UITextField *avgOppositeTemp;
@property (strong, nonatomic) IBOutlet UITextField *hignTempDays;

- (IBAction)alertYearMonthPickerView:(UITextField *)sender;
- (IBAction)alertTownSelectView:(UITextField *)sender;
- (IBAction)alertPartMonthView:(UITextField *)sender;

- (IBAction)touchDownBackground:(id)sender;
//编辑初始化方法
- (id)initWithWeatherInfo:(WeatherInfoEntity*) weatherInfo;

@end
