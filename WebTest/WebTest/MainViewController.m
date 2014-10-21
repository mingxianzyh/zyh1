//
//  MainViewController.m
//  WebTest
//
//  Created by sunlight on 14-9-17.
//  Copyright (c) 2014年 wisdom. All rights reserved.
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
    UIWebView *webView = (UIWebView *)self.view;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://218.1.17.162/jqmobi/home.html"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
