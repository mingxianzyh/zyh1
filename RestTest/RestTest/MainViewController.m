//
//  MainViewController.m
//  RestTest
//
//  Created by sunlight on 14-7-23.
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
    // Do any additional setup after loading the view.
    [self requestRestService];
}

//rest 测试服务
- (void)requestRestService{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.50.137:8080/Cxf/userRestManage/user/userName"]];
    request.HTTPMethod = @"GET";
    
    NSURLConnection *con = [NSURLConnection connectionWithRequest:request delegate:self];
    [con start];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"%@",error);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"%@",response);
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
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
