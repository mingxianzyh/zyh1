//
//  MainViewController.m
//  UIWebViewTest
//
//  Created by sunlight on 14-9-25.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.delegate = self;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"1" ofType:@"html"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    //插入JS代码
    [webView stringByEvaluatingJavaScriptFromString:@""];
    
    self.webView = webView;
    [self.view addSubview:webView];
    
}


#pragma mark 网页代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestString = [[request URL] absoluteString];
    NSRange range = [requestString rangeOfString:@"open"];
    if (range.length > 0) {
         [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
          "script.type = 'text/javascript';"
          "script.text = \"function myFunction(a) { "
          "alert(a);"
           "}\";"
            "document.getElementsByTagName('head')[0].appendChild(script);"];
        
        [webView stringByEvaluatingJavaScriptFromString:@"myFunction('12345');"];
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
