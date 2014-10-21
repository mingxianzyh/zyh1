//
//  ToolBarViewController.h
//  First
//
//  Created by sunlight on 14-3-10.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueViewController.h"
#import "GreenViewController.h"

@interface ToolBarViewController : UIViewController

@property (retain,nonatomic) BlueViewController *blueViewController;
@property (retain,nonatomic) GreenViewController *greenViewContriller;
- (IBAction)switchView:(id)sender;

@end
