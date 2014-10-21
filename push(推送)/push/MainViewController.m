//
//  MainViewController.m
//  push
//
//  Created by sunlight on 14-5-28.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "PushNetwork.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UITableView *workTableView;

@property (strong, nonatomic) NSArray *dataArray;

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


//从后台加载数据
- (void)loadDataFromService{


}
//注册token
- (void)registerToken:(NSString *)token{
    
    [PushNetwork registerDevice:token];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"工作台";
    _dataArray = [UIFont familyNames];
}

#pragma tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDENTIFY = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFY];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFY];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request{

}
- (void)requestFailed:(ASIHTTPRequest *)request{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
