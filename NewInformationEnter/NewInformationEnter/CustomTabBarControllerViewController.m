//
//  CustomTabBarControllerViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#import "CustomTabBarControllerViewController.h"
@interface CustomTabBarControllerViewController ()

@end

@implementation CustomTabBarControllerViewController

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
    //创建自定义tabbar
    [self createCustomTabBar];
    //初始化子视图控制器
    [self createSubViewControllers];
}

//创建自定义tabbar
- (void)createCustomTabBar{
    //隐藏tabBar
    self.tabBar.hidden = YES;
    //默认选择第一个Tab
    self.selectedIndex = 0;
    //自定义tabBar
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBar"]];
    tabBarImageView.frame = CGRectMake(0, 1024-49, 768, 49);
    tabBarImageView.userInteractionEnabled = YES;
    int width = 200;
    for (int i = 0; i < 2; i++ ) {
        //在imageView上设置按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(260+width*i, 9, 30, 31);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]] forState:UIControlStateNormal];
        button.tag = i+1;
        //增加自定义按钮事件
        [button addTarget:self action:@selector(changTabIndex:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarImageView addSubview:button];
        
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectbackground"]];
    imageView.frame = CGRectMake(250, 2, 54, 45);
    self.selectedBackgroudImage = imageView;
    [tabBarImageView addSubview:imageView];
    [self.view addSubview:tabBarImageView];
    //自定义tabBar结束

}

//创建tabbar内容控制器
- (void)createSubViewControllers{
    //录入tabbar 导航控制器控制器
    //初始化时给一个空根视图
    UINavigationController *enterNavigationController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    //默认push气象信息controller
    [enterNavigationController pushViewController:[[WeatherViewController alloc] init] animated:NO];
    //设置navigationBar背景图片
    [enterNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar"] forBarMetrics:UIBarMetricsDefault];
    self.enterNavigationController = enterNavigationController;
    //self.enterNavigationController.navigationBarHidden = YES;
    
//    //查询tabbar 导航控制器(切换table时，并不去重新push视图控制器，只是重新设置table的数据源)
    UINavigationController *selectNavigationController = [[UINavigationController alloc] initWithRootViewController:[[WeatherSelectViewController alloc] init]];
    //默认push气象信息Select controller
//    [selectNavigationController pushViewController:[[WeatherSelectViewController alloc] init] animated:NO];
    
    //设置navigationBar背景图片
    [selectNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar"] forBarMetrics:UIBarMetricsDefault];
    self.selectNavigationController = selectNavigationController;
    
    NSArray *controllers = @[self.selectNavigationController,self.enterNavigationController];
    self.viewControllers = controllers;
}

//在设置master 中table选中以后，在这里需要隐藏浮动视图
- (void)setIndex:(int)index{
    _index = index;
    //在设置标志的时候取消浮动视图(master隐藏)
    [self.popController dismissPopoverAnimated:YES];
    //切换右边detail视图
    [self changeInputViewOnSelect:index];
}

- (void)changTabIndex:(UIButton*)button{
    //点击按钮时改变选中图片和选择的tabBar
    [UIView beginAnimations:@"moveBackgroudImage" context:nil];
    self.selectedIndex = button.tag-1;
    CGRect frame =  self.selectedBackgroudImage.frame;
    frame.origin.x = button.frame.origin.x - 10;
    self.selectedBackgroudImage.frame = frame;
    [UIView commitAnimations];
}

//如果导航tableview改变后，所有tabbar都更新当前显示的视图(分开更新会出现bug，处理起更麻烦)
- (void)changeInputViewOnSelect:(NSInteger) index{
    
    //获取当前查询视图控制器
    WeatherSelectViewController *selectController = (WeatherSelectViewController*)[self.selectNavigationController topViewController];
    //设置当前选中的导航标记
    selectController.index = _index;
    //说明当前选中的时搜索页，需要立即加载数据(否则，在viewWillAppear时去加载)
    if (self.selectedIndex==0) {
        //刷新数据源
        [selectController loadTableViewDatasource];
    }else{
        //当前搜索table数据源已经失效,需要清空
        selectController.array = nil;
    }
    switch (_index) {
        case 0:{
            //退出上一个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //进入当前视图(气象信息)
            WeatherViewController *controller0 = [[WeatherViewController alloc] init];
            [self.enterNavigationController pushViewController:controller0 animated:YES];
            break;
        }
        case 1:{
            //退出上一个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //灾害信息
            DisasterViewController *controller1 = [[DisasterViewController alloc] init];
            [self.enterNavigationController pushViewController:controller1 animated:YES];
            break;
        }
        case 2:{
            //退出上个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //施肥记录
            ApplyFertilizerViewController *controller2 = [[ApplyFertilizerViewController alloc] init];
            [self.enterNavigationController pushViewController:controller2 animated:YES];
            break;
        }
        case 3:{
            //退出上个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //施药记录
            ApplyMedicineViewController *controller3 = [[ApplyMedicineViewController alloc] init];
            [self.enterNavigationController pushViewController:controller3 animated:YES];
            break;
        }
        case 4:{
            //退出上个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //生育期记录
            BirthViewController *controller4 = [[BirthViewController alloc] init];
            [self.enterNavigationController pushViewController:controller4 animated:YES];
            break;
        }
        case 5:{
            //退出上个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //农艺性状信息
            AgriCultureViewController *controller5 = [[AgriCultureViewController alloc] init];
            [self.enterNavigationController pushViewController:controller5 animated:YES];
            
            break;
        }
        case 6:{
            //退出上个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //育苗管理
            SeedGrowViewController *controller6 = [[SeedGrowViewController alloc] init];
            [self.enterNavigationController pushViewController:controller6 animated:YES];
            
            break;
        }
        case 7:{
            //退出上个视图
            [self.enterNavigationController popViewControllerAnimated:NO];
            //移栽管理
            TransPlantViewController *controller7 = [[TransPlantViewController alloc] init];
            [self.enterNavigationController pushViewController:controller7 animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma split delegate methods
// Called when a button should be added to a toolbar for a hidden view controller.
// Implementing this method allows the hidden view controller to be presented via a swipe gesture if 'presentsWithGesture' is 'YES' (the default).(横向时调用)
- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    //保留浮动窗口引用，以便于在master控制器中进行隐藏操作
    self.popController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.(纵向时调用)
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    
}

// Called when the view controller is shown in a popover so the delegate can take action like hiding other popovers.(推送出来popoverController时触发)
- (void)splitViewController:(UISplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController{
    
}

// Returns YES if a view controller should be hidden by the split view controller in a given orientation.
// (This method is only called on the leftmost view controller and only discriminates portrait from landscape.)
- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
