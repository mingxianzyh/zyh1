//
//  MainViewController.m
//  MotionTest
//
//  Created by sunlight on 14-9-15.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>

//加速计和陀螺仪不好封装,并且很简单,所以就无需封装
@interface MainViewController ()
//加速计
@property (strong, nonatomic) IBOutlet UILabel *accelerometerX;
@property (strong, nonatomic) IBOutlet UILabel *accelerometerY;
@property (strong, nonatomic) IBOutlet UILabel *accelerometerZ;
//陀螺仪
@property (strong, nonatomic) IBOutlet UILabel *gyroscopeX;
@property (strong, nonatomic) IBOutlet UILabel *gyroscopeY;
@property (strong, nonatomic) IBOutlet UILabel *gyroscopeZ;

//coreMotion 核心类
@property (strong, nonatomic) CMMotionManager *motionManage;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSTimer *timer;

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

- (void)viewWillAppear:(BOOL)animated{
    
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateDatas) userInfo:nil repeats:YES];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    //[self.timer invalidate];
    //self.timer = nil;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self genCoreMotion1];
    //[self genCoreMotion2];
    
}

- (void)genCoreMotion1{
    
    float shakeValue = 1.5;
    //1.使用队列以及Block来获取加速计以及陀螺仪数据
    self.motionManage = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    //加速计
    if ([self.motionManage isAccelerometerAvailable]) {
        self.motionManage.accelerometerUpdateInterval = 1.0/10.0;
        [self.motionManage startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            if (error) {
                [self.motionManage stopAccelerometerUpdates];
                NSLog(@"%@",error);
            }else{
                static NSInteger shakeCount;
                static NSDate *shakeDate;
                
                NSDate *now = [NSDate date];
                NSDate *checkDate = [shakeDate dateByAddingTimeInterval:1.5];
                if (shakeDate == nil || [checkDate compare:now] == NSOrderedAscending) {
                    shakeDate = now;
                    shakeCount = 0;
                }
                if (fabs(accelerometerData.acceleration.x)>shakeValue || fabs(accelerometerData.acceleration.y)>shakeValue || fabs(accelerometerData.acceleration.z)>shakeValue) {
                    if (shakeCount == 4) {
                        NSLog(@"1.5S检测到四次摇动");
                        //ipad没有震动
                        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        
                        AudioServicesPlaySystemSound(1109);
                        
                        shakeDate = now;
                        shakeCount = 0;
                    }else{
                        shakeCount ++;
                    }
                }else{
                    [self.accelerometerX performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.x] waitUntilDone:NO];
                    [self.accelerometerY performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.y] waitUntilDone:NO];
                    [self.accelerometerZ performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.z] waitUntilDone:NO];
                }
            }
        }];
    }
    //陀螺仪
    if ([self.motionManage isGyroAvailable]) {
        self.motionManage.gyroUpdateInterval = 1.0/10.0;
        [self.motionManage startGyroUpdatesToQueue:self.queue withHandler:^(CMGyroData *gyroData, NSError *error) {
            if (error) {
                [self.motionManage stopGyroUpdates];
                NSLog(@"%@",error);
            }else{
                [self.gyroscopeX performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",gyroData.rotationRate.x] waitUntilDone:NO];
                [self.gyroscopeY performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",gyroData.rotationRate.y] waitUntilDone:NO];
                [self.gyroscopeZ performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",gyroData.rotationRate.z] waitUntilDone:NO];
            }
        }];
    }
}

- (void)genCoreMotion2{
    
    //1.使用队列以及Block来获取加速计以及陀螺仪数据
    self.motionManage = [[CMMotionManager alloc] init];
    //加速计
    if ([self.motionManage isAccelerometerAvailable]) {
        self.motionManage.accelerometerUpdateInterval = 1.0/10.0;
        [self.motionManage startAccelerometerUpdates];
         
    }
    //陀螺仪
    if ([self.motionManage isGyroAvailable]) {
        self.motionManage.gyroUpdateInterval = 1.0/10.0;
        [self.motionManage startGyroUpdates];
    }
}

//震动检测方式三
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{

    NSLog(@"开始");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{

    NSLog(@"结束");
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{

    NSLog(@"取消");
}

- (void)updateDatas{
    
    
    [self.accelerometerX performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",self.motionManage.accelerometerData.acceleration.x] waitUntilDone:NO];
    [self.accelerometerY performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",self.motionManage.accelerometerData.acceleration.y] waitUntilDone:NO];
    [self.accelerometerZ performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",self.motionManage.accelerometerData.acceleration.z] waitUntilDone:NO];
    [self.gyroscopeX performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",self.motionManage.gyroData.rotationRate.x] waitUntilDone:NO];
    [self.gyroscopeY performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",self.motionManage.gyroData.rotationRate.y] waitUntilDone:NO];
    [self.gyroscopeZ performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f",self.motionManage.gyroData.rotationRate.z] waitUntilDone:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
