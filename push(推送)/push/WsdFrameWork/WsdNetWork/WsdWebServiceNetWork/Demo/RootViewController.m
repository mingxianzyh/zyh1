//
//  RootViewController.m
//  JastorDemo
//
//  Created by sunlight on 14-5-5.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "UserDto.h"
#import "WsdNetWorkService.h"
#import "ASIHTTPRequest.h"
#import "WsdBeanUtil.h"
#import "Jastor.h"
#import "WsdServiceResponse.h"

@interface RootViewController ()

@property (nonatomic,strong) NSArray *users;


@end

@implementation RootViewController

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
    /*
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    //设置pageSize
//    [request setFetchLimit:1];
//    //设置开始位置(row)
//    [request setFetchOffset:0];
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array!=nil && [array count]>0) {
        User *user = array[0];
        [user setValue:@"zhangsan" forKey:@"userName"];
        [user setValue:@"1" forKey:@"id"];
        [user setValue:@"WSD792" forKey:@"userCode"];
        [context save:&error];
        self.user = user;
    }else{
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [user setValue:@"zhangsan" forKey:@"userName"];
        [user setValue:@"1" forKey:@"id"];
        [user setValue:@"WSD792" forKey:@"userCode"];
        self.user = user;
        [context save:&error];
    }
    
    UserDto *dto = [WsdBeanUtil converPoToDto:self.user];
    NSLog(@"%@",[Jastor converJsonFromObject:dto]);
    NSLog(@"---------------------------");
    NSLog(@"%@",[dto toJson]);
    //[WsdNetWorkService queryUserInfoByPageNo:0 AndPageSize:10 AndDelegate:self];
    */
//    NSString *json = @"{\"id\":\"1\",\"userCode\":\"WSD792\",\"userName\":\"zhangsan\"}";
//    
//    UserDto *dto = [Jastor objectFormJson:json AndClassName:NSStringFromClass([UserDto class])];
//    NSLog(@"%@",dto);
    [WsdNetWorkService queryUserInfoByPageNo:0 AndPageSize:10 AndDelegate:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.users) {
        return [self.users count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    User *user = self.users[indexPath.row];
    cell.textLabel.text = user.userName;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    WsdServiceResponse *response = [WsdNetWorkUtil genWsdServiceResponseByResponseSoapMessage:request.responseString AndResponseObjectClass:[UserDto class]];
    if (response.result) {
        //AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        //同步数据
        /*
        self.users = [WsdBeanUtil synchroizePos:nil AndDtos:response.responseObjects WithContext:delegate.managedObjectContext isDeleteNotExistsPo:NO];
            [self.tableView reloadData];
         */
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
    }else{
        NSLog(@"%@",@"请求失败");
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"获取数据失败!");
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
