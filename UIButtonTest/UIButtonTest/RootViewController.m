//
//  RootViewController.m
//  UIButtonTest
//
//  Created by sunlight on 14-3-11.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "RootViewController.h"
#import "MySearchBarDelegate.h"
#import "SecondViewController.h"

@interface RootViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    // Do any additional setup after loading the view from its nib.
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(320/2-60/2, 480/2-30/2, 60, 30);
//    [button setTitle:@"button" forState:UIControlStateNormal];
//    [button setTitle:@"click" forState:UIControlStateSelected];
//    [button setTitle:@"selected" forState:UIControlStateHighlighted];
//    [button setSelected:YES];
//    [button sizeToFit];
//    button.enabled = false;
//    [self.view addSubview:button];
    
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 50, 120, 30)];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    [self.view addSubview:textField];
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.keyboardType = UIKeyboardTypeNumberPad;
//    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
//    textField.delegate = self;
//    [textField release];
    
    
//    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 60, 280, 20)];
//    slider.minimumValue = 0;
//    slider.maximumValue = 100;
//    slider.value = 20;
//    [slider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:slider];
//    [slider release];
    
    
//    NSArray *items = [NSArray arrayWithObjects:@"搜索",@"视频",@"图片",@"音乐", nil];
//    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
//    segment.frame = CGRectMake(0, 430, 320, 30);
//    segment.segmentedControlStyle = UISegmentedControlStyleBar;
//    segment.selectedSegmentIndex=0;
//    [segment addTarget:self action:@selector(segmentJudge:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:segment];
//    [segment release];
    
    
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 430, 320, 30)];
//    pageControl.backgroundColor = [UIColor blackColor];
//    pageControl.numberOfPages = 1;
//    //pageControl.currentPage = 5;
//    pageControl.enabled = NO;
//    pageControl.hidesForSinglePage = YES;
//    [self.view addSubview:pageControl];
//    [pageControl release];

//    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
//    indicatorView.center = CGPointMake(160, 230);
//    indicatorView.color = [UIColor redColor];
//    //indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    [self.view addSubview:indicatorView];
//    [indicatorView release];
//    [indicatorView startAnimating];
//    
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(stopIndicatorView:) userInfo:indicatorView repeats:NO];
    
 //   UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(320/2-200/2, 460/2-30/2, 200, 30)];
    //searchBar.prompt = @"搜索";
//    searchBar.placeholder = @"请输入";
 //   MySearchBarDelegate *delegate = [[MySearchBarDelegate alloc] init];
//    searchBar.delegate = delegate;
//    searchBar.showsCancelButton = YES;
//    [self.view addSubview:searchBar]
//    [searchBar release];
    
//    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(140, 230, 0, 0)];
//    switchButton.on = YES;
//    [self.view addSubview:switchButton];
//    [switchButton release];
    
//    //进度视图
//    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 60, 280, 20)];
//    [progressView setProgress:0.5f];
//    [self.view addSubview:progressView];
//    [progressView release];
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    pushButton.frame = CGRectMake(320/2-60/2, (480-44-20)/2-30/2, 60, 30);
    [pushButton addTarget:self action:@selector(addSubView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    [pushButton release];
    
    self.navigationItem.title=@"Root";
}

- (void) addSubView{

    SecondViewController *secondController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondController animated:YES];
    [secondController release];

}

- (void)stopIndicatorView:(NSTimer*)timer{
    
    UIActivityIndicatorView *indicatorView = [timer userInfo];
    [indicatorView stopAnimating];
    
}

- (void)segmentJudge:(UISegmentedControl *) segment{

    NSLog(@"%l",segment.selectedSegmentIndex);
}

- (void)moveSlider:(UISlider*) slider{
    NSLog(@"%i",(int)slider.value);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.location<=5){
        return YES;
    }else{
        return NO;
    }
}

@end
