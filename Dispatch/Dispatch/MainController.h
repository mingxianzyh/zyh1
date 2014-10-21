//
//  MainController.h
//  Dispatch
//
//  Created by sunlight on 14-3-28.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController
- (IBAction)loadImage:(UIButton *)sender;
- (IBAction)clearImage:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
