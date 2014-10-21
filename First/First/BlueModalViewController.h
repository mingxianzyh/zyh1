//
//  BlueModalViewController.h
//  First
//
//  Created by sunlight on 14-3-11.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlueModalViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *changedTextField;
- (IBAction)endEditing:(UITextField *)sender;
- (IBAction)quitModelView:(UIButton *)sender;
@end
