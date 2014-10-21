//
//  PrivateViewController.m
//  UITableTest
//
//  Created by sunlight on 14-3-18.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "PrivateViewController.h"

@interface PrivateViewController ()

@end

@implementation PrivateViewController

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(320/2-50, 396/2-15, 100, 30);
    [button setTitle:@"Table View" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showTable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.title = @"个人";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTable{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.frame = CGRectMake(0, 0, 320, 480);
    viewController.view.backgroundColor = [UIColor whiteColor];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        [viewController.view addSubview:tableView];
        tableView.dataSource = self;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:viewController animated:YES];
        [tableView release];
    [viewController release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 3;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0) {
        
        if(indexPath.row == 0){
            cell.textLabel.text = @"用户设置";
        }else{
            cell.textLabel.text = @"版本信息";
            
        }
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"账户安全";
        }else if(indexPath.row==1){
            cell.textLabel.text = @"手机密码";
            
        }else{
            cell.textLabel.text = @"支付设置";
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
@end
