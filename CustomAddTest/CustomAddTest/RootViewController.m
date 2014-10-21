//
//  RootViewController.m
//  CustomAddTest
//
//  Created by sunlight on 14-5-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "RootViewController.h"
#import "AllItemTableViewController.h"
#import "MainControllerUtil.h"
#import "BaseViewController.h"

@interface RootViewController ()

@property (nonatomic,strong) NSMutableArray *functionControllers;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIPageControl *pageControl;

//判断编辑状态
@property (nonatomic,assign) BOOL isEditing;

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

- (void)viewDidAppear:(BOOL)animated{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0f) {
//        CGRect frame = self.view.frame;
//        frame.size.height = frame.size.height-20.0f;
//        self.view.frame = frame;
//    }
    self.view.frame = CGRectMake(0, 0, 768, 1024);
    // Do any additional setup after loading the view.
    [self createCustomView];
    
}

//创建自定义视图
- (void)createCustomView{
    //增加手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    CGRect frame = self.view.frame;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    //标题View
    UIImageView *titleImageView = [[UIImageView alloc] init];
    titleImageView.frame =CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 200);
    
    //分页View
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(frame.size.width/2-100/2, frame.size.height - 100, 100, 50)];
    [pageControl hidesForSinglePage];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageControl = pageControl;
    
    //scroll View
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(frame.origin.x, frame.origin.y+200, frame.size.width, frame.size.height-200-100);
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    //设置内容尺寸(必须大于scroll frame尺寸才会有拖动效果)
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width+1,scrollView.frame.size.height);
    //此方法可以设置可视视图的起始点位置
    //scrollView setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>
    scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    tap1.numberOfTapsRequired = 1;
    [scrollView addGestureRecognizer:tap1];
    frame.size.width += frame.size.width/2;
    imageView.frame = frame;
    [self.view addSubview:imageView];
    [self.view addSubview:titleImageView];
    [self.view addSubview:pageControl];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSMutableArray *menuButtons = [[NSMutableArray alloc] init];
    NSMutableArray *functionControllers = [[NSMutableArray alloc] init];
    //1.创建添加按钮
    WsdMenuButton *addButton = [WsdMenuButton wsdMenuButtonWithType:UIButtonTypeCustom HasRemoveButton:NO];
    [addButton setTitle:@"add" forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"blueButton.jpg"] forState:UIControlStateNormal];
    addButton.tag = 0;
    [addButton addTarget:self action:@selector(presentModelController:) forControlEvents:UIControlEventTouchUpInside];
    [menuButtons addObject:addButton];
    AllItemTableViewController *allItemsController = [[AllItemTableViewController alloc] init];
    [functionControllers addObject:allItemsController];
    
    //2.创建其他视图按钮
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:kPersistenceList withExtension:kPlistFileName];
    NSArray *controllerNames = [NSArray arrayWithContentsOfURL:url];
    if (controllerNames!=nil&&[controllerNames count]>0) {
        NSArray *otherMenuButtons = [self genWsdMenuButtonsByClassNames:controllerNames];
        NSArray *otherFunctionControllers =[MainControllerUtil genViewControllersByClassNames:controllerNames];
        [menuButtons addObjectsFromArray:otherMenuButtons];
        [functionControllers addObjectsFromArray:otherFunctionControllers];
    }
    self.menuButtons = menuButtons;
    self.functionControllers = functionControllers;
    //3.调整菜单位置
    [self adjustMenuViews];

}

//根据类名获取相应的菜单集合
- (NSArray *)genWsdMenuButtonsByClassNames:(NSArray *)classNames{
    NSMutableArray * menuButtons = [[NSMutableArray alloc] initWithCapacity:[classNames count]];
    
    for (int i = 0 ; i < [classNames count] ; i++) {

        WsdMenuButton *menuButton = [WsdMenuButton wsdMenuButtonWithType:UIButtonTypeCustom HasRemoveButton:YES];
//        [menuButton setTitle:[controller valueForKey:@"title"] forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:classNames[i]];
        if (image==nil) {
            image =[UIImage imageNamed:@"blueButton.jpg"];
        }
        [menuButton setBackgroundImage:image forState:UIControlStateNormal];
        //menuButton.frame = CGRectMake(100, 100, 200, 200);
        [menuButton addTarget:self action:@selector(presentModelController:) forControlEvents:UIControlEventTouchUpInside];
        [menuButtons addObject:menuButton];
    }
    return menuButtons;
}

//调整菜单按钮在scrollView上的位置
- (void)adjustMenuViews{
    
    //一页画布
    float gridWidth = self.view.frame.size.width;
    float gridHeight = self.scrollView.frame.size.height;
    //水平菜单按钮间隙
    float rowMenuSpace = (gridWidth - kGridRows*kMenuButtonWidth)/(kGridRows+1);
    //垂直菜单按钮间隔
    float colMenuSpace = (gridHeight - kGridCols*kMenuButtonHeight)/(kGridCols+1);
    float opposX = 0.0f;
    float x = rowMenuSpace;
    float y = colMenuSpace;
    for (int i = 0 ; i < [self.menuButtons count]; i++) {
        //设置标题
        WsdMenuButton *button = self.menuButtons[i];
        button.delegate = self;
        button.tag = i;
        //翻页
        if (i != 0&&i%(kGridCols*kGridRows) == 0) {
            opposX += self.view.frame.size.width;
            x = opposX + rowMenuSpace;
            y = colMenuSpace;
        //换行
        }else if(i !=0 && i%kGridRows == 0){
            y += colMenuSpace + kMenuButtonHeight;
            x = opposX+rowMenuSpace;

        }
        button.frame = CGRectMake(x,y, kMenuButtonWidth, kMenuButtonHeight);
        [self.scrollView addSubview:button];
        //正常移动X
        x += rowMenuSpace+ kMenuButtonWidth;
        
    }
    int count = (int)[self.menuButtons count]/(kGridRows*kGridCols);
    if ([self.menuButtons count]%(kGridRows*kGridCols)>0) {
        count++;
    }
    self.pageControl.numberOfPages = count;
    self.scrollView.contentSize = CGSizeMake(count*self.view.frame.size.width,self.scrollView.frame.size.height);
}

//分页动作
- (void)changePage:(UIPageControl *)pageControl{

    int page = pageControl.currentPage;
    //动画改变内容视图
    [self.scrollView setContentOffset:CGPointMake(page*self.view.frame.size.width, 0) animated:YES];
}

//弹出选中视图viewControll
- (void)presentModelController:(WsdMenuButton *)button{
    
    UINavigationController *ncController = [[UINavigationController alloc] initWithRootViewController:self.functionControllers[[self.menuButtons indexOfObject:button]]];
//    ncController.navigationBar.translucent = NO;
//    ncController.edgesForExtendedLayout = UIRectEdgeNone;
//    ncController.extendedLayoutIncludesOpaqueBars = NO;
//    ncController.modalPresentationCapturesStatusBarAppearance = NO;
//    ncController.automaticallyAdjustsScrollViewInsets= YES;
    
    [ncController.navigationBar setBackgroundImage:[UIImage imageNamed:@"1"] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
//    ncController.view.frame = self.view.frame;
    //设置动画风格(浮动消失)
    ncController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:ncController animated:YES completion:nil];
}


#pragma MenuButon delegate
//点击删除小按钮后调用
- (void)clickLittleDeleteButton:(WsdMenuButton *) wsdMenuButton{
    //1.移动删除按钮与菜单按钮
    [wsdMenuButton.subviews performSelector:@selector(removeFromSuperview)];
    [wsdMenuButton removeFromSuperview];
    //2.同步到当前数据源
    int index = [self.menuButtons indexOfObject:wsdMenuButton];
    [self.menuButtons removeObjectAtIndex:index];
    [self.functionControllers removeObjectAtIndex:index];
    //3.保存到list文件中
    [self saveSelectedControllerNames];

}
#pragma target
//长按按钮后调用
- (void)longPressMenuButton{
    
    if (self.isEditing) {
        return;
    }
    for (WsdMenuButton *button in self.menuButtons) {
        [self enableEditing:button];
    }
    self.isEditing = YES;
}
//单机背景后调用
- (void)tapView{
    
    if (self.isEditing) {
        for (WsdMenuButton *button in self.menuButtons) {
            [self disableEditing:button];
        }
        self.isEditing = NO;
    }
}

- (void) enableEditing:(WsdMenuButton *)menuButton {
    
    
    // make the remove button visible
    [menuButton.deleteButton setHidden:NO];
    [menuButton setEnabled:NO];
    // start the wiggling animation
    CGFloat rotation = 0.03;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    //在完成from到to后 在从to执行到from
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(menuButton.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(menuButton.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    
    [menuButton.layer addAnimation:shake forKey:@"shakeAnimation"];
    
    // inform the springboard that the menu items are now editable so that the springboard
    // will place a done button on the navigationbar
    //[(SESpringBoard *)self.delegate enableEditingMode];
    
}

- (void) disableEditing:(WsdMenuButton *)menuButton {
    [menuButton.layer removeAnimationForKey:@"shakeAnimation"];
    [menuButton.deleteButton setHidden:YES];
    [menuButton setEnabled:YES];
}


#pragma scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    
    int index = scrollView.contentOffset.x/self.view.frame.size.width;
    if (index != self.pageControl.currentPage) {
        if ((int)scrollView.contentOffset.x%(int)self.view.frame.size.width == 0) {
            self.pageControl.currentPage = index;
        }
    }

}                                            // any offset changes
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2); // any zoom scale changes
//
//// called on start of dragging (may require some time and or distance to move)
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{


}

//adjust IOS7 statusBae
- (BOOL)prefersStatusBarHidden{

    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        CGRect frame = self.view.frame;
//        frame.size. = frame.size.height+20.0f;
//        self.view.frame = fr

    }else{

    }
}

//保存
- (void)saveSelectedControllerNames{
    
    NSMutableArray *classNames = [[NSMutableArray alloc] init];
    for (id obj in self.functionControllers) {
        if ([obj isKindOfClass:[BaseViewController class]]) {
         [classNames addObject:NSStringFromClass([obj class])];
        }
    }
    //使用bundle获取URL
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:kPersistenceList withExtension:kPlistFileName];
    [classNames writeToURL:url atomically:YES];

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
