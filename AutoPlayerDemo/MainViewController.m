//
//  MainViewController.m
//  AutoPlayerDemo
//
//  Created by sunlight on 14-3-31.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

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
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:[bundle pathForResource:@"Deep" ofType:@"mp3"]];
    _avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置音量为0.5
    _avAudioPlayer.volume = 0.5;
    //设置播放模式
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    _processSlider.minimumValue = 0;
    _processSlider.maximumValue = _avAudioPlayer.duration;
    
    //因为在主线程，所以没用NSRunLoop也能循环执行
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVoiceLabel) userInfo:nil repeats:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//开始或暂停
- (IBAction)beginPlayer:(UIButton *)sender {
    if ([_avAudioPlayer isPlaying]) {
        [_avAudioPlayer pause];
        [_controlButton setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [_avAudioPlayer play];
        [_controlButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

//停止播放
- (IBAction)stopPlayer:(UIButton *)sender {
    [_avAudioPlayer stop];
    _avAudioPlayer.currentTime = 0;
    [_controlButton setTitle:@"播放" forState:UIControlStateNormal];
}
//进度的控制
- (IBAction)processChange:(UISlider *)sender {
    _avAudioPlayer.currentTime = sender.value;
}
//声音的控制
- (IBAction)touchVoiceSlider:(UISlider *)sender {
    NSLog(@"%f",sender.value);
    _avAudioPlayer.volume = sender.value;
}
//改变label的值(循环执行)
- (void)changeVoiceLabel{
    NSLog(@"111");
    _showVoiceLabel.text = [NSString stringWithFormat:@"%.0f",_avAudioPlayer.currentTime];
    _processSlider.value = _avAudioPlayer.currentTime;
}
@end
