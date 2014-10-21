//
//  CustomPickerView.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-14.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomPickerView;
//delegate
@protocol CustomPickerDelegate <NSObject>

@optional

- (void)selectedDate:(CustomPickerView*)pickerView;

@end


//自定义时间选择器(年月日时分秒)
@interface CustomPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>{
@private
    NSArray *_years;
    NSArray *_months;
}
@property (nonatomic,assign) id<CustomPickerDelegate> customDelegate;
//最大时间
@property (nonatomic,strong) NSDate *maxYear;
//最小时间
@property (nonatomic,strong) NSDate *minYear;
//当前时间
@property (nonatomic,strong) NSDate *date;

@end

