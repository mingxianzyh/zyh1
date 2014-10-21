//
//  MainController.m
//  Dispatch
//
//  Created by sunlight on 14-3-28.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@end

@implementation MainController

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
    self.view.backgroundColor = [UIColor blackColor];
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    view.frame = CGRectMake(768/2, 1024/2, 20, 20);
    view.tag = 101;
    [self.imageView addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImage:(UIButton *)sender {
    
//    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    view.frame = CGRectMake(768/2, 1024/2, 20, 20);
//    view.tag = 101;
//    [self.imageView addSubview:view];
  
    NSurl *url = [NSURL URLWithString:@"www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        NSLog(@"%@",data);
    }];
 
    
}

- (IBAction)clearImage:(UIButton *)sender {
    
    self.imageView.image = nil;
}
@end
