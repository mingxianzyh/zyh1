//
//  RootViewController.h
//  NewProject
//
//  Created by 学鸿 张 on 13-11-29.
//  Copyright (c) 2013年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol WsdScanViewControllerDelegate <NSObject>

@required
//完成二维码的扫描
- (void)didFinishScanData:(id)data;

@end

@interface WsdScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (weak,nonatomic)id<WsdScanViewControllerDelegate> delegate;
//@property (nonatomic, retain) UIImageView * line;

@end
