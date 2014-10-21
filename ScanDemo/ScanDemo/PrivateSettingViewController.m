//
//  PrivateSettingViewController.m
//  ScanDemo
//
//  Created by sunlight on 14-9-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "PrivateSettingViewController.h"
#import "UIView+Ext.h"


@interface PrivateSettingViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PrivateSettingViewController

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
    [self adjustView];
}
#pragma mark 修改适配View
- (void)adjustView{
    self.navigationItem.title = @"个人设置";
    
}

#pragma mark tableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0, 50.0, self.tableView.rowHeight)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+20.0, 0.0, 200.0, self.tableView.rowHeight)];
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.tag = indexPath.row;
    switchView.center = CGPointMake(self.tableView.width-switchView.width/2.0-10.0, self.tableView.rowHeight/2.0);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.tableView.rowHeight-1,switchView.left, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    switch (indexPath.row) {
        case 0:
            textLabel.text = @"地理位置";
            break;
        case 1:
            textLabel.text = @"设备信息";
            break;
        case 2:
            textLabel.text = @"个人爱好";
            break;
        default:
            break;
    }
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:textLabel];
    [cell.contentView addSubview:switchView];
    [cell.contentView addSubview:lineView];
    return cell;
}


#pragma mark tableView 代理
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
