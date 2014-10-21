//
//  MainViewController.m
//  ZBarTest
//
//  Created by sunlight on 14-9-10.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "WsdScanZbarViewController.h"
#import "WsdScanViewController.h"
#import "UIView+Ext.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isAnimate;

- (IBAction)scan:(id)sender;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scan:(id)sender {
    
    if (iOS>=7.0) {
        [self presentViewController:[[WsdScanViewController alloc] init] animated:YES completion:^{
            
        }];
        
    }else{
        WsdScanZbarViewController *zbarVC = [[WsdScanZbarViewController alloc] init];
        zbarVC.readerDelegate = self;
        zbarVC.interfaceOrientationMasks = UIInterfaceOrientationMaskPortrait;
        //非全屏
        [self presentViewController:zbarVC animated:YES completion:^{
            
        }];
    }
    /*
    ZBarReaderViewController *zbarVC = [[ZBarReaderViewController alloc] init];
    [zbarVC setSupportedOrientationsMask:ZBarOrientationMask(UIInterfaceOrientationPortrait)];
    zbarVC.readerDelegate = self;
    ZBarImageScanner *scanner = zbarVC.scanner;
    //通用设置
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    //隐藏底部控制按钮
    zbarVC.showsZBarControls = NO;
    zbarVC.readerView.torchMode = 0;
    //非全屏
    //zbarVC.edgesForExtendedLayout = UIRectEdgeLeft;
    //自定义扫描View设置
    [self setOverlayPickerView:zbarVC];
    [self presentViewController:zbarVC animated:YES completion:^{
        
    }];
    */
     
}

- (void)setOverlayPickerView:(ZBarReaderViewController *)reader

{
    //清除原有控件
    for (UIView *temp in [reader.view subviews]) {
        for (UIButton *button in [temp subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar in [temp subviews]) {
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                [toolbar setHidden:YES];
                [toolbar removeFromSuperview];
            }
        }
    }
    
    UIColor *comonBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    UIView *overlayView = [[UIView alloc] init];
    if (reader.navigationController && !reader.navigationController.navigationBarHidden) {
        overlayView.frame = CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height - 64.0);
    }else{
        overlayView.frame = CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height);
    }
    reader.cameraOverlayView = overlayView;
    
    
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height/2-kPicHeight/2)];
    //upView.alpha = commonAlpha;
    upView.backgroundColor = comonBackgroundColor;
    upView.tag = 100;
    [overlayView addSubview:upView];
    
    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(upView.width/2.0-kPicWidth/2.0, upView.bottom-50.0, kPicWidth, 50);
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离摄像头10CM左右，系统会自动识别。";
    [upView addSubview:labIntroudction];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.bottom,kScreen_Width/2.0-kPicWidth/2.0, kPicHeight)];
    leftView.backgroundColor = comonBackgroundColor;
    leftView.tag = 101;
    [overlayView addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(leftView.right+kPicWidth, leftView.top, leftView.width, leftView.height)];
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
    middleImageView.bounds = CGRectMake(0.0, 0.0, kPicWidth, kPicHeight);
    middleImageView.center = CGPointMake(kScreen_CenterX, kScreen_CenterY);
    [overlayView addSubview:middleImageView];
    
    //画中间的基准线
    UIImageView* lineView = [[UIImageView alloc] initWithFrame:CGRectMake(middleImageView.width/2.0-380.0/2.0, 0, 380, 15.0)];
    lineView.image = [UIImage imageNamed:@"2"];
    [middleImageView addSubview:lineView];
    
    //设置有效扫描区域(全屏为(0,0,1,1)) 最好放大50
    [reader setScanCrop:CGRectMake((leftView.right-50)/kScreen_Width, (upView.bottom-50)/kScreen_Height, (kPicWidth+100)/kScreen_Width, (kPicHeight+100)/kScreen_Height)];
    
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
            newFrame.origin.y += kPicHeight;
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
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark UIImagePickerVC delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //Zbar从这里获取扫描的数据
    id results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    _imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    _label.text = symbol.data;

}
@end
