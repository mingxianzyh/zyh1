//
//  ViewController1.m
//  CustomAddTest
//
//  Created by sunlight on 14-5-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController1.h"
#import "WsdSignView.h"


@interface ViewController1 ()

@property (nonatomic,strong) WsdSignView *signView;
@property (nonatomic,strong) UIImageView *imageView;
//签名按钮
@property (nonatomic,strong) UIButton *signButton;

@end

@implementation ViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init{

    self = [super init];
    
    if (self) {
        //定义一些基本属性信息
        self.title = @"签名";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *createImageButton = [[UIBarButtonItem alloc] initWithTitle:@"生成图像" style:UIBarButtonItemStyleBordered target:self action:@selector(createImage)];
    [createImageButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"开始签名" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(signBeginOrEnd:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(768-100, 2, 100, 40);
    UIBarButtonItem *signButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:signButton,createImageButton, nil];
    self.signButton = button;
    
    WsdSignView *signView = [[WsdSignView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 768.0f, 1024.0f-64.0f-200)];
    signView.wsdSignType = WsdSignTypeBezier;
    signView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:signView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(768/2-200/2,760.0f, 200, 200.0f)];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    self.signView = signView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma private methods begin

- (void)signBeginOrEnd:(UIButton *)button{
    
    WsdSignView *signView = self.signView;
    //NSLog(@"%d",[signView.path isEmpty]);//1=YES
    
    if (signView.isSigning) {
        [signView endSign];
        [button setTitle:@"开始签名" forState:UIControlStateNormal];
    }else{
        //如果封装的路径不为nil，则提示是否要覆盖
        if (signView.hasContent) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否覆盖签名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }else{
            //第一次加载
            [signView beginSign];
            [button setTitle:@"完成签名" forState:UIControlStateNormal];
        }
    }
}

- (void)createImage{
    //图片最好等比压缩
    UIImage *image = [self.signView gainCurrentSignImageBySize:self.imageView.bounds.size];
    self.imageView.image = image;

}
#pragma end

#pragma alertView delegate begin
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        WsdSignView *signView = self.signView;
        [signView beginSign];
        [self.signButton setTitle:@"完成签名" forState:UIControlStateNormal];
    }
}
#pragma end



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
