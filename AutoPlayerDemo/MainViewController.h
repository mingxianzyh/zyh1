//
//  MainViewController.h
//  AutoPlayerDemo
//
//  Created by sunlight on 14-3-31.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : UIViewController
- (IBAction)beginPlayer:(UIButton *)sender;
- (IBAction)stopPlayer:(UIButton *)sender;
- (IBAction)processChange:(UISlider *)sender;
- (IBAction)touchVoiceSlider:(UISlider *)sender;
@property (strong, nonatomic) IBOutlet UISlider *changeVoice;
@property (strong, nonatomic) IBOutlet UISlider *processSlider;

@property (strong, nonatomic) IBOutlet UIButton *controlButton;
@property (strong, nonatomic) IBOutlet UILabel *showVoiceLabel;
@property (strong, nonatomic) AVAudioPlayer *avAudioPlayer;
@property (strong, nonatomic) NSTimer *timer;

@end
