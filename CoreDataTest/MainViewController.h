//
//  MainViewController.h
//  CoreDataTest
//
//  Created by sunlight on 14-4-23.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)selectSegment:(UISegmentedControl *)sender;

@end
