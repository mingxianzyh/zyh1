//
//  BlueViewController.m
//  First
//
//  Created by sunlight on 14-3-10.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "BlueViewController.h"
#import "BlueModalViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

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
    if(self.view.window == nil){
        self.view = nil;
    }
}

- (void)dealloc{
    NSLog(@"blue view dealloc");
    [_blueLabel release];
    [_blueLabel release];
    [super dealloc];
}
- (IBAction)blueButtonClick:(UIButton *)sender {
    //注册一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabel:) name:@"changeLabelNotice" object:nil];
    
    BlueModalViewController *modelView = [[BlueModalViewController alloc] initWithNibName:@"BlueModalViewController" bundle:nil];
    [self presentViewController:modelView animated:YES completion:^{
        NSLog(@"call back");
    }];
    [modelView release];
}

- (void) changeLabel:(NSNotification*) notice{
    NSLog(@"%@",notice.object);
    self.blueLabel.text = notice.object;
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeLabelNotice" object:nil];
}
@end
