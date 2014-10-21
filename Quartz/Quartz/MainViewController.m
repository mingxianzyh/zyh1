//
//  MainViewController.m
//  Quartz
//
//  Created by sunlight on 14-4-25.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "Header.h"
#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic) kColor color;
@property (nonatomic) KShape shape;

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

- (IBAction)changeColor:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case kRedColor:{
            break;
        }
        case kGreenColor:{
            break;
        }

            
        default:
            break;
    }
}

- (IBAction)changeShape:(UISegmentedControl *)sender {
}


@end
