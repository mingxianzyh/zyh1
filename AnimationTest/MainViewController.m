//
//  MainViewController.m
//  AnimationTest
//
//  Created by sunlight on 14-3-25.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeView:(UIButton *)sender {
        
    /*
    [UIView transitionWithView:_subView duration:2.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [_subView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    } completion:^(BOOL finished) {
        
    }];
     */
    CATransition *caTransition = [[CATransition alloc] init];
    caTransition.duration = 2.0;
    caTransition.type = kCATransitionMoveIn;
    caTransition.subtype = kCATransitionFromRight;
    [_subView.layer addAnimation:caTransition forKey:@"T"];
    [_subView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [caTransition release];

}
- (void)dealloc {
    [_subView release];
    [super dealloc];
}
@end
