//
//  MainViewController.m
//  DrawImageTest
//
//  Created by sunlight on 14-8-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "CTView.h"

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
    // Do any additional setup after loading the view.
    [self createCustomView2];
}
- (void)createCustomView2{
    CGRect rect = CGRectMake(768/2-300/2, 1024/2-300/2, 300, 300);
    CTView *ctView = [[CTView alloc] initWithFrame:rect];
    ctView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ctView];
}
- (void)createCustomView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor cyanColor] CGColor]);

    CGRect rect = CGRectMake(768/2-300/2, 1024/2-300/2, 300, 300);
    CGContextFillRect(context, rect);
    //UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image = image;
    [self.view addSubview:imageView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
