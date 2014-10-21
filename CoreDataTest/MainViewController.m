//
//  MainViewController.m
//  CoreDataTest
//
//  Created by sunlight on 14-4-23.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "Person.h"
#define kPerson @"Person"

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
    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    NSError *error;
//    
//    NSManagedObjectContext *context = [delegate managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kPerson];
//    NSArray *objs = [context executeFetchRequest:request error:&error];
//    if (objs!=nil&&[objs count]>0) {
//        for (Person *obj in objs) {
//            NSLog(@"%@",[obj valueForKey:@"name"]);
//            NSLog(@"%@",obj.name);
//        }
//    }else{
//        NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:kPerson inManagedObjectContext:context];
//        [obj setValue:@"zhangsan" forKey:@"name"];
//        [context save:&error];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectSegment:(UISegmentedControl *)sender {
    
}
@end
