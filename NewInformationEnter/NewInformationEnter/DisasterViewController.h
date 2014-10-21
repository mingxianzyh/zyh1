//
//  DisasterViewController.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

//灾害信息
@interface DisasterViewController : ContentViewController

//灾害描述
@property (strong, nonatomic) IBOutlet UITextView *disasterDescribe;
//灾害措施
@property (strong, nonatomic) IBOutlet UITextView *disasterMeasure;

@end
