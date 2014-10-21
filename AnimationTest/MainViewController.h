//
//  MainViewController.h
//  AnimationTest
//
//  Created by sunlight on 14-3-25.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController

- (IBAction)changeView:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *subView;

@end
