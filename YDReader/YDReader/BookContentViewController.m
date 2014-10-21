//
//  BookContentViewController.m
//  YDReader
//
//  Created by sunlight on 14-10-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "YDTextView.h"
#import "BookContentViewController.h"


@interface BookContentViewController ()
@property (strong, nonatomic) YDTextView *bookTextView;
@end

@implementation BookContentViewController

- (instancetype)initWithBookInfo:(BookInfo *)book{
    
    self = [super init];
    if (self) {
        self.bookInfo = book;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL flag = self.navigationController.navigationBar.translucent;
     flag = self.tabBarController.tabBar.translucent;
    [self loadBook];
    [self createCustomView];
    [self adjustView];
    
}
#pragma mark 加载书籍
- (void)loadBook{
    if (self.bookInfo) {
        NSError *error;
        NSString *bookContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        self.bookInfo.bookContent = bookContent;
    }
}
- (void)createCustomView{
    self.view.backgroundColor = [UIColor whiteColor];

    self.bookTextView = [[YDTextView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height-64.0-49.0)];
    self.bookTextView.delaysContentTouches = NO;
    self.bookTextView.editable = NO;
    self.bookTextView.selectable = NO;
    self.bookTextView.text = self.bookInfo.bookContent;
    [self.view addSubview:self.bookTextView];
}

#pragma mark 调整视图
- (void)adjustView{
    self.navigationItem.title = self.bookInfo.bookName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    

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
