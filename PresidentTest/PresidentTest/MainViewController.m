//
//  MainViewController.m
//  PresidentTest
//
//  Created by sunlight on 14-4-22.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "Person.h"

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
    /*
    NSFileManager *manage = [[NSFileManager alloc] init];
    if([manage fileExistsAtPath:[self pathForDocuments]]){
        
        NSArray *array = [NSArray arrayWithContentsOfFile:[self pathForDocuments]];
        for (NSString* str in array) {
            NSLog(@"%@",str);
        }
    }else{
        
        NSArray *array = @[@"1",@"2",@"3",@"4"];
        [array writeToFile:[self pathForDocuments] atomically:YES];

    }
     */
    NSFileManager *manage = [[NSFileManager alloc] init];
    if([manage fileExistsAtPath:[self pathForDocuments:@"person.archive"]]){
    
    
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self pathForDocuments:@"person.archive"]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        Person *person = [unarchiver decodeObjectForKey:@"person"];
        [unarchiver finishDecoding];
        NSLog(@"%@",person);
    }else{
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        Person *person = [[Person alloc] init];
        person.name = @"zhangsan";
        person.age = 22;
        [archiver encodeObject:person forKey:@"person"];
        [archiver finishEncoding];
        [data writeToFile:[self pathForDocuments:@"person.archive"] atomically:YES];
    }
        

}

- (NSString *)pathForDocuments:(NSString *)path{

    NSString *path1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path1 stringByAppendingPathComponent:path];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
