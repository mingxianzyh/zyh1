//
//  MainViewController.m
//  BlueToothTest
//
//  Created by sunlight on 14-8-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"

//client(中心设备) 搜索周边设备 请求数据
@interface MainViewController ()

//中心管理类
@property (nonatomic,strong) CBCentralManager *centralManage;
@property (nonatomic,copy) NSString *serviceUUID;
@property (nonatomic,copy) NSString *characteristicUUID;

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
    // Do any additional setup after loading the view.
    [self createCustomView];
    [self createInitData];
}

- (void)createInitData{
    
    self.serviceUUID = [self genUUID];
    self.characteristicUUID = [self genUUID];
    
}

- (void)createCustomView{
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startButton.frame = CGRectMake(1024.0/2-100/2, 768.0/2-100.0/2, 100, 100);
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}

//开始搜索设备
- (void)start{
    if (!self.centralManage) {
        self.centralManage = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    
}

//获取UUID
- (NSString *)genUUID{
    
    NSString *UUID = [[NSUUID UUID] UUIDString];
    return UUID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark centralManage delegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    NSLog(@"%d",central.state);
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            [self.centralManage scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            
            break;
            
        default:
            break;
    }

}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"扫描到周边设备");

}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{

}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{


}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
