//
//  BlueModalViewController.m
//  First
//
//  Created by sunlight on 14-3-11.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "BlueModalViewController.h"

@interface BlueModalViewController ()

@end

@implementation BlueModalViewController

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

- (void)dealloc {
    [_changedTextField release];
    [super dealloc];
}

- (IBAction)endEditing:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)quitModelView:(UIButton *)sender {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLabelNotice" object:self.changedTextField.text];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"quit");
    }];
}
@end
