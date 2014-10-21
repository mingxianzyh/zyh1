//
//  MainScanViewController.m
//  ScanDemo
//
//  Created by sunlight on 14-9-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainScanViewController.h"
#import "UIView+Ext.h"
#import "EquInfo.h"

@interface MainScanViewController ()

@property (strong,nonatomic) AVCaptureDevice * device;
@property (strong,nonatomic) AVCaptureDeviceInput * input;
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
@property (strong,nonatomic) AVCaptureSession * session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preview;

@property (strong, nonatomic) IBOutlet UITextView *scanTextView;
@property (strong, nonatomic) IBOutlet UIImageView *scanResultImage;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isAnimate;
@property (strong, nonatomic) UIImageView *middleImageView;
@property (strong, nonatomic) UILabel *labIntroudction;
@property (strong, nonatomic) CLLocationManager *locationManage;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) CLLocation *location;
@property (assign, nonatomic) BOOL isScaning;

@end

@implementation MainScanViewController

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
    [self adjustViewController];
    [self setupCamera];
    [self createScanLine];
    [self beginScan];
    
}

- (void)adjustViewController{
    
    self.navigationItem.title = @"扫描";
    self.scanResultImage.hidden = YES;
    self.scanResultImage.backgroundColor = [UIColor redColor];
    
    //初始化定位信息
    self.locationManage = [[CLLocationManager alloc] init];
    //刷新距离为10米
    [self.locationManage setDistanceFilter:10];
    //设置精度
    [self.locationManage setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    self.locationManage.delegate = self;
    self.queue = [[NSOperationQueue alloc] init];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(refreshScan) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0.0, 0.0, 50.0, 44.0);
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    UIBarButtonItem *refreshBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = refreshBarItem;
    
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
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.scanResultImage.frame;
    
}
// 创建扫描的线条和边框
- (void)createScanLine{
    
    UIImageView *middleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    middleImageView.frame = self.scanResultImage.frame;
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(self.scanResultImage.left,self.scanResultImage.top-50.0, self.scanResultImage.width, 50.0);
    labIntroudction.font = [UIFont systemFontOfSize:12.0];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor blackColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离摄像头10CM左右，系统会自动识别并显示。";
    self.labIntroudction = labIntroudction;
    [self.view addSubview:labIntroudction];
    //画中间的基准线
    UIImageView* lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, middleImageView.width, 15.0)];
    lineView.image = [UIImage imageNamed:@"2"];
    lineView.tag = 101;
    [middleImageView addSubview:lineView];
    [self.view addSubview:middleImageView];
    self.middleImageView = middleImageView;

}

- (void)refreshScan{
    self.scanTextView.text = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginScan];
    });

}
#pragma mark 开始扫描
- (void)beginScan{
    if (self.isScaning) {
        return;
    }
    self.isScaning = YES;
    // Start
    self.labIntroudction .hidden = NO;
    self.middleImageView.hidden = NO;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    [_session startRunning];
    UIView* lineView = [self.middleImageView viewWithTag:101];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(lineAnimate:) userInfo:lineView repeats:YES];
    [timer setFireDate:[NSDate date]];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
    self.scanResultImage.hidden = YES;
}
#pragma mark 结束扫描
- (void)endScan{
    // Start
    [_session stopRunning];
    [self.timer invalidate];
    self.timer = nil;
    
    [self.preview removeFromSuperlayer];
    self.scanResultImage.hidden = NO;
    self.middleImageView.hidden = YES;
    self.isScaning = NO;
    self.labIntroudction .hidden = YES;
}

#pragma mark 线条移动
//线条移动动画
- (void)lineAnimate:(NSTimer *)timer{
    if (!self.isAnimate) {
        self.isAnimate = YES;
        UIView *lineView = timer.userInfo;
        lineView.alpha = 1.0;
        CGRect frame = lineView.frame;
        [UIView animateWithDuration:3.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect newFrame = frame;
            newFrame.origin.y += self.middleImageView.height-lineView.height;
            lineView.frame = newFrame;
        } completion:^(BOOL finished) {
            lineView.frame = frame;
            lineView.alpha = 0.0;
            self.isAnimate = NO;
        }];
    }
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if ([metadataObjects count]>0) {
        [self endScan];
        AVMetadataMachineReadableCodeObject *resultData = metadataObjects[0];
        NSString *resultString = [resultData stringValue];
        NSDate *scanDate = [NSDate date];
        self.scanTextView.text = resultString;
        [self.queue addOperationWithBlock:^{
            EquInfo *equObj = [[EquInfo alloc] init];
            //1.获取经纬度信息
            [self.locationManage startUpdatingLocation];
            while (!self.location) {
                [NSThread sleepForTimeInterval:1.0];
            }
            [self.locationManage stopUpdatingLocation];
            CLLocation *location = self.location;
            self.location = nil;
            equObj.longitude = location.coordinate.longitude;
            equObj.latitude = location.coordinate.latitude;
            equObj.accuracy = self.locationManage.desiredAccuracy;
            equObj.lop = location.horizontalAccuracy;
            equObj.va = location.verticalAccuracy;
            equObj.lh = location.altitude;
            equObj.getLocationTime = location.timestamp;
            //2.获取扫描的信息
            equObj.scanTime = scanDate;
            equObj.qriInfo = resultString;
            //手机号码与IMEI获取不到
            //3.数据发送
            
        }];
    }
}
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    if (newLocation.horizontalAccuracy > 0 && newLocation.verticalAccuracy > 0) {
        self.location = newLocation;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
