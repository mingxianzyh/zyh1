//
//  RootViewController.m
//  YDReader
//
//  Created by sunlight on 14-10-8.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "YDView.h"
#import "BookInfo.h"
#import "YDTapGestureRecognizer.h"
#import "BookStoreViewController.h"
#import "BookContentViewController.h"

#define kYCount 3
#define kXCount 3

@interface BookStoreViewController ()

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *booksArray;

@property (strong,nonatomic) NSTimer *converTimer;

@property (strong,nonatomic) NSArray *colors;


@end

@implementation BookStoreViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self initTimer];
    [self loadBooks];
    [self.tableView reloadData];

}
- (void)viewDidDisappear:(BOOL)animated{
    [self destoryTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomView];
    
    UIColor *color1 = RGBAlpha(39, 237, 197, 0.1);
    UIColor *color2 = RGBAlpha(39, 237, 197, 0.3);
    UIColor *color3 = RGBAlpha(39, 237, 197, 0.5);
    NSArray *colors = @[(__bridge id)[color1 CGColor],(__bridge id)[color2 CGColor],(__bridge id)[color3 CGColor]];
    self.colors = colors;
    
}
#pragma mark 创建定时器
- (void)initTimer{
    
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:3] interval:3 target:self selector:@selector(converGradientView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.converTimer = timer;
}
#pragma mark 销毁定时器
- (void)destoryTimer{
    
    [self.converTimer invalidate];
    self.converTimer = nil;
}

#pragma mark 加载图书数据
- (void)loadBooks{
    NSMutableArray *booksArray = [[NSMutableArray alloc] init];

    BookInfo *bookInfo = [[BookInfo alloc] init];
    bookInfo.bookName = @"1";
    bookInfo.bookType = YDBookTypeTXT;
    
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    [booksArray addObject:bookInfo];
    
    self.booksArray = booksArray;
}

#pragma mark 创建自定义视图
- (void)createCustomView{

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height-64.0-49.0)];
    //允许ScrollView在垂直方法一直滚动
    tableView.alwaysBounceVertical = YES;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    /*
     CAGradientLayer *layer = [self genGradientLayer:colors];
     YDView *longContentView = [[YDView alloc] initWithFrame:CGRectMake(0.0,i*scrollView.height/kYCount, scrollView.width, scrollView.height/kYCount-1) gradientLayer:layer];
     */

}

#pragma mark 生成渐变GradientLayer
- (CAGradientLayer *)genGradientLayer:(NSArray*)cgColors{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = cgColors;
    layer.startPoint = CGPointMake(0.0, 0.0);
    layer.endPoint = CGPointMake(0.0, 1.0);
    return layer;
}
#pragma mark 变幻定时器调用方法
- (void)converGradientView{
    
    float r = arc4random()%255;
    float g = arc4random()%255;
    float b = arc4random()%255;
    
    NSArray *colors = @[(__bridge id)RGBAlpha(r,g,b,0.1).CGColor,(__bridge id)RGBAlpha(r,g,b,0.3).CGColor,(__bridge id)RGBAlpha(r,g,b,0.5).CGColor];
    
    self.colors = colors;
    [self.tableView reloadData];
}

#pragma mark tableView delegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.tableView.height/kYCount;
}
#pragma matk tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rowNums = 0;
    if ([self.booksArray count]/kXCount < kYCount) {
        rowNums = kYCount;
    }else{
        rowNums = [self.booksArray count]/kXCount;
        if ([self.booksArray count]%kXCount > 0) {
            rowNums++;
        }
    }
    return rowNums;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDENTIFY = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFY];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFY];
        YDView *contentView = [[YDView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.width, tableView.height/kYCount) gradientLayer:[self genGradientLayer:self.colors]];
        contentView.tag = 100;
        if ([self.booksArray count] > indexPath.row*kXCount) {
            float spaceX = contentView.width*0.35/(kXCount+1);
            float width = contentView.width *0.65/kXCount;
            
            float spaceY = contentView.height*0.3/2;
            NSInteger count = [self.booksArray count] - indexPath.row*kXCount;
            if (count > kXCount) {
                count = kXCount;
            }
            //处理每一行的每一本书
            for (int i = 0 ; i < count; i++) {
                
                UIView *bookCoverView = [[UIView alloc] initWithFrame:CGRectMake((i+1)*spaceX+i*width, spaceY, width, contentView.height-2*spaceY)];
                bookCoverView.backgroundColor = [UIColor grayColor];
                BookInfo *bookInfo = self.booksArray[indexPath.row*kXCount+i];
                YDTapGestureRecognizer *tapGR = [[YDTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBook:)];
                tapGR.obj1 = bookInfo;
                [bookCoverView addGestureRecognizer:tapGR];
                [contentView addSubview:bookCoverView];
            }
            
        }
        [cell.contentView addSubview:contentView];
    }
    YDView *contentView = (YDView *)[cell.contentView viewWithTag:100];
    contentView.gradientLayer = [self genGradientLayer:self.colors];
    return cell;
}

#pragma mark 每本书的点击手势事件
- (void)tapBook:(YDTapGestureRecognizer *)tapGR{
    
    BookInfo *bookInfo = tapGR.obj1;
    BookContentViewController *contentVC = [[BookContentViewController alloc] initWithBookInfo:bookInfo];
    [self.navigationController pushViewController:contentVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
