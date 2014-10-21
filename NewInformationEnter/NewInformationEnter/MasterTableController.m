//
//  MasterTableControllerT.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MasterTableController.h"

@interface MasterTableController ()

//上次选择的cell
@property (strong,nonatomic)NSIndexPath *lastSelectedIndexPath;

@end

@implementation MasterTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _masterArray = @[@"田间气象信息", @"灾害信息",@"施肥记录",@"施药记录",@"生育期记录",@"农艺性状信息",@"育苗管理",@"移栽管理"];
    //不显示分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //页面出来时候显示已选择项
    self.clearsSelectionOnViewWillAppear = NO;
    //不显示垂直滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //定义第一行的位置
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //默认选择第一行
    [self.tableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:firstPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebackground2"]];
    self.lastSelectedIndexPath = firstPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_masterArray count];
}

//设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell重用
    static NSString *identify = @"masterCell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 identify];
    if (cell == nil) {
        //这种方式不会使用重用机制
        NSBundle *boudle = [NSBundle mainBundle];
        cell = [boudle loadNibNamed:@"CustomTableViewCell" owner:(self) options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//      //这种方式可以重用
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
//        //设置单元格的风格
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        //设置单元格的内容视图--增加下划线
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 68, 320, 2)];
//        imageView.image = [UIImage imageNamed:@"lineView"];
//        [cell.contentView addSubview:imageView];
    }
    //赋值操作
    cell.contentLabel.text = _masterArray[indexPath.row];
    return cell;
}



#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath;
}
//tableView的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (NSOrderedSame != [self.lastSelectedIndexPath compare:indexPath]) {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:self.lastSelectedIndexPath];
        lastCell.backgroundView = nil;
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebackground2"]];
        
        CustomTabBarControllerViewController *detailTabBarControlelr =  self.splitViewController.viewControllers[1];
        //这里需要切换视图
        detailTabBarControlelr.index = (int)indexPath.row;
        self.lastSelectedIndexPath = indexPath;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
