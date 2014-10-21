//
//  MainViewController.m
//  MPPlotTest
//
//  Created by sunlight on 14-8-22.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "SingleBrokenLinViewController.h"
#import "SingleCureLineViewController.h"
#import "DoubleLineViewController.h"
#import "DoubleCureLineViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

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
}



#pragma mark tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    switch (indexPath.row) {
        case 0:{
        
            cell.textLabel.text = @"单折线";
        }
            break;
        case 1:{
            
            cell.textLabel.text = @"单折线(圆滑)";
        }
            break;
        case 2:{
            
            cell.textLabel.text = @"双折线";
        }
            break;
        case 3:{
            
            cell.textLabel.text = @"双折线圆滑";
        }
            break;
        case 4:{
            
            cell.textLabel.text = @"单柱线";
        }
            break;
        case 5:{
            
            cell.textLabel.text = @"多柱线";
        }
            break;
        case 6:{
            
            cell.textLabel.text = @"饼状图";
        }
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark tableView代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            SingleBrokenLinViewController *vc = [[SingleBrokenLinViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        	}
            break;
        case 1:{
            SingleCureLineViewController *vc = [[SingleCureLineViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            DoubleLineViewController *vc = [[DoubleLineViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            DoubleCureLineViewController *vc = [[DoubleCureLineViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
            break;
        case 6:{
            
        }
            break;
        default:
            break;
    }


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
