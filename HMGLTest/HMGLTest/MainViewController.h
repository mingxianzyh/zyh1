//
//  MainViewController.h
//  HMGLTest
//
//  Created by sunlight on 14-3-26.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
- (IBAction)switchView:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end
