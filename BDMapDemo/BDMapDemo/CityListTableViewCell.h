//
//  CityListTableViewCell.h
//  BDMapDemo
//
//  Created by sunlight on 14-5-19.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *downloadIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *gotoImage;
@property (strong, nonatomic) IBOutlet UIButton *downButton;
@property (strong, nonatomic) IBOutlet UIProgressView *downProgressView;
//城市ID字段
//@property (assign, nonatomic) NSInteger cityId;

@end
