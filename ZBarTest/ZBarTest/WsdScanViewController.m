
#import "WsdScanViewController.h"
#import "UIView+Ext.h"

@interface WsdScanViewController ()

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isAnimate;

@end

@implementation WsdScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}
- (void)setupCamera
{
    //1.初始化设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.初始化输入
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    //3.初始化输出
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //4.初始化Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }

    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    //设置扫描的区域
    _output.rectOfInterest =  CGRectMake((kScreen_CenterX-kPicWidth/2.0)/kScreen_Width,(kScreen_CenterY-kPicHeight/2.0)/kScreen_Height, kPicWidth/kScreen_Width, kPicHeight/kScreen_Height);
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,kScreen_Width,kScreen_Height);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *comonBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    UIView *overlayView = [[UIView alloc] init];
    if (self.navigationController && !self.navigationController.navigationBarHidden) {
        overlayView.frame = CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height - 64.0);
    }else{
        overlayView.frame = CGRectMake(0.0, 0.0, kScreen_Width, kScreen_Height);
    }
    [self.view insertSubview:overlayView atIndex:0];
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
    [cancelButton addTarget:self action:@selector(dismissOverlayView)forControlEvents:UIControlEventTouchUpInside];
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
    //[reader setScanCrop:CGRectMake((leftView.right-50)/kScreen_Width, (upView.bottom-50)/kScreen_Height, (kPicWidth+100)/kScreen_Width, (kPicHeight+100)/kScreen_Height)];
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
-(void)dismissOverlayView
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.timer invalidate];
    }];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
   
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
   [self dismissViewControllerAnimated:YES completion:^
    {
        [self.timer invalidate];
        NSLog(@"%@",stringValue);
        if ([self.delegate respondsToSelector:@selector(didFinishScanData:)]) {
            [self.delegate didFinishScanData:stringValue];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
