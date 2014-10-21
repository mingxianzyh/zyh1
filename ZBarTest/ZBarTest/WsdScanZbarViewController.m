//
//  WsdScanViewController.m
//  ZBarTest
//
//  Created by sunlight on 14-9-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//



#import "UIView+Ext.h"
#import "WsdScanZbarViewController.h"
#import "Common.h"

@interface WsdScanZbarViewController ()

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isAnimate;

@end

@implementation WsdScanZbarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
        self.interfaceOrientationMasks = UIInterfaceOrientationMaskAllButUpsideDown;
        if (isDevicePad) {
            self.scanWidth = 400.0;
            self.scanHeight = 400.0;
        }else{
            self.scanWidth = 400.0;
            self.scanHeight = 400.0;
        }
    }
    return self;
}
- (void)loadView{
    [super loadView];
    //这两个属性需要在这里设置,在viewDidLoad之前
    self.showsZBarControls = NO;
    self.readerView.torchMode = 0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
     [self createZBarView];
}
- (void)createZBarView{
    //自定义扫描View设置
    [self setOverlayPickerView];
}
- (void)setOverlayPickerView{
    //清除原有控件
    for (UIView *temp in [self.view subviews]) {
        for (UIButton *button in [temp subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar1 in [temp subviews]) {
            if ([toolbar1 isKindOfClass:[UIToolbar class]]) {
                [toolbar1 setHidden:YES];
                [toolbar1 removeFromSuperview];
            }
        }
    }
    UIView *overlayView = [[UIView alloc] init];
    if (self.navigationController && !self.navigationController.navigationBarHidden) {
        overlayView.frame = CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height - 64.0);
    }else{
         overlayView.frame = CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height);
    }
    self.cameraOverlayView = overlayView;
    
    UIColor *comonBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height/2-self.scanWidth/2)];
    //upView.alpha = commonAlpha;
    upView.backgroundColor = comonBackgroundColor;
    upView.tag = 100;
    [overlayView addSubview:upView];
    
    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(upView.width/2.0-self.scanWidth/2.0, upView.bottom-50.0, self.scanWidth, 50);
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离摄像头10CM左右，系统会自动识别。";
    [upView addSubview:labIntroudction];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.bottom,kScreen_Width/2.0-self.scanWidth/2.0, self.scanHeight)];
    leftView.backgroundColor = comonBackgroundColor;
    leftView.tag = 101;
    [overlayView addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(leftView.right+self.scanWidth, leftView.top, leftView.width, leftView.height)];
    rightView.backgroundColor = comonBackgroundColor;
    rightView.tag = 102;
    [overlayView addSubview:rightView];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, leftView.bottom, kScreen_Width, kScreen_Height-leftView.bottom)];
    downView.backgroundColor = comonBackgroundColor;
    downView.tag = 103;
    [overlayView addSubview:downView];
    
    //用于取消操作的button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.alpha = 0.5;
    [cancelButton setFrame:CGRectMake(kScreen_Width/2.0-200/2.0, kScreen_Height-100.0, 200.0, 40.0)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:cancelButton];
    
    UIImageView *middleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    middleImageView.bounds = CGRectMake(0.0, 0.0, self.scanWidth, self.scanHeight);
    middleImageView.center = CGPointMake(kScreen_CenterX, kScreen_CenterY);
    [overlayView addSubview:middleImageView];
    
    //画中间的基准线
    UIImageView* lineView = [[UIImageView alloc] initWithFrame:CGRectMake(middleImageView.width/2.0-380.0/2.0, 0, 380, 15.0)];
    lineView.image = [UIImage imageNamed:@"2"];
    [middleImageView addSubview:lineView];
    
    //设置有效扫描区域(全屏为(0,0,1,1)) 最好放大50
    [self setScanCrop:CGRectMake((leftView.right-50)/kScreen_Width, (upView.bottom-50)/kScreen_Height, (self.scanWidth+100)/kScreen_Width, (self.scanHeight+100)/kScreen_Height)];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(lineAnimate:) userInfo:lineView repeats:YES];
    [timer setFireDate:[NSDate date]];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

//线条移动动画
- (void)lineAnimate:(NSTimer *)timer{
    if (!self.isAnimate) {
        self.isAnimate = YES;
        UIView *lineView = timer.userInfo;
        lineView.alpha = 1.0;
        CGRect frame = lineView.frame;
        [UIView animateWithDuration:3.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect newFrame = frame;
            newFrame.origin.y += self.scanHeight;
            lineView.frame = newFrame;
        } completion:^(BOOL finished) {
            lineView.frame = frame;
            lineView.alpha = 0.0;
            self.isAnimate = NO;
        }];
    }
}


//取消button方法
- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
         [self.timer invalidate];
    }];
}

//旋转时重构视图
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
- (BOOL)shouldAutorotate{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations{

    return self.interfaceOrientationMasks;
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
