//
//  CustomPickerView.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-14.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "CustomPickerView.h"

@implementation CustomPickerView


- (id)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self createDateSourceArray];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self createDateSourceArray];
    }
    return self;
}


#pragma private method begin
//初始化固定数组
- (void)createDateSourceArray{
    
    NSMutableArray *mutableMonths = [[NSMutableArray alloc] initWithCapacity:12];
    for (int i = 1; i <= 12; i++) {
        [mutableMonths addObject:[NSNumber numberWithInt:i]];
    }
    _months = mutableMonths;
    
    NSMutableArray *mutableYears = [[NSMutableArray alloc] initWithCapacity:201];
    for (int i = 1900; i<=2100; i++) {
        [mutableYears addObject:[NSNumber numberWithInt:i]];
    }
    _years = mutableYears;
}


#pragma private method end



// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger result = 0;
    switch (component) {
        case 0:{
            result = 201;
            break;
        }
        case 1:{
            result = 12;
            break;
        }
        default:
            break;
    }
    return result;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat width = 0.0;
    
    switch (component) {
        case 0:{
            width = 100;
            break;
        }
        case 1:{
            width = 100;
            break;
        }
        default:
            break;
    }
    return width;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title ;
    switch (component) {
        case 0:{
            title = [NSString stringWithFormat:@"%d年",[_years[row] intValue]];
            break;
        }
        case 1:{
            title = [NSString stringWithFormat:@"%d月",[_months[row] intValue]];
            break;
        }
        default:
            break;
    }
    return title;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//
//    
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    if (component == 0) {
        components.year = [_years[row] intValue];
        components.month = [_months[[pickerView selectedRowInComponent:1]] intValue];
        
    }else if(component == 1){
        components.month = [_months[row] intValue];
        components.year = [_years[[pickerView selectedRowInComponent:0]] intValue];
        
    }
    self.date = [calendar dateFromComponents:components];
    [self.customDelegate selectedDate:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
