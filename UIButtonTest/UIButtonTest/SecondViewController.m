//
//  SencondViewController.m
//  UIButtonTest
//
//  Created by sunlight on 14-3-12.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UIButton *hidenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hidenButton.frame = CGRectMake(320/2-60/2, (480-44-20)/2-30/2, 60, 30);
    [hidenButton setTitle:@"hideen" forState:UIControlStateNormal];
    [hidenButton addTarget:self action:@selector(hidenBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hidenButton];
    
    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    popButton.frame = CGRectMake(320/2-60/2, (480-44-20)/2-30+50, 60, 30);
    [popButton setTitle:@"pop" forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
    
    UIButton *rootButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rootButton.frame = CGRectMake(320/2-60/2, (480-44-20)/2-30+100, 60, 30);
    [rootButton setTitle:@"Root" forState:UIControlStateNormal];
    [rootButton addTarget:self action:@selector(backRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rootButton];
    [self.navigationController setTitle:@"111"];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(popView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [leftButton release];
   
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(popView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.title = @"Second";
    [rightButton release];
    
    UIBarButtonItem *first = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:nil];
    UIBarButtonItem *second = [[UIBarButtonItem alloc ] initWithTitle:@"转发1" style:UIBarButtonItemStyleDone target:self action:nil];
    UIBarButtonItem *three = [[UIBarButtonItem alloc ] initWithTitle:@"转发2" style:UIBarButtonItemStyleBordered target:self action:nil];
    UIBarButtonItem *four = [[UIBarButtonItem alloc ] initWithTitle:@"转发3" style:UIBarButtonItemStylePlain target:self action:nil];
    NSArray *items = @[first,second,three,four];
    
    self.toolbarItems = items;
    
    [first release];
    [second release];
    [three release];
    [four release];
    
}

- (void)backRoot{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hidenBar{
    if([self.navigationController isNavigationBarHidden] == YES){
        [self.navigationController setToolbarHidden:NO animated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
        [self.navigationController setToolbarHidden:YES animated:YES];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
