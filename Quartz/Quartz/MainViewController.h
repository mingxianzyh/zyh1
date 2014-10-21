//
//  MainViewController.h
//  Quartz
//
//  Created by sunlight on 14-4-25.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *colorSegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *shapeChange;

- (IBAction)changeColor:(UISegmentedControl *)sender;
- (IBAction)changeShape:(UISegmentedControl *)sender;

@end
