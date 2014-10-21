//
//  MainViewController.m
//  CFNetwork_socket_server
//
//  Created by sunlight on 14-7-23.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <CoreFoundation/CFRunLoop.h>
#import <CoreFoundation/CFBase.h>
#import <CFNetwork/CFNetwork.h>

@interface MainViewController ()

@end

@implementation MainViewController

CFSocketRef _socket;
CFWriteStreamRef _outputStream = NULL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (int)setUpSocket{
    
    _socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAcceptCallBack, TCPServerAcceptCallBack, NULL);
    if (NULL == _socket) {
        NSLog(@"Cannot create socket!");
        return 0;
    }
    
    int optval = 1;
    setsockopt(CFSocketGetNative(_socket), SOL_SOCKET, SO_REUSEADDR, // 允许重用本地地址和端口
               (void *)&optval, sizeof(optval));
    
    struct sockaddr_in addr4;
    memset(&addr4, 0, sizeof(addr4));
    addr4.sin_len = sizeof(addr4);
    addr4.sin_family = AF_INET;
    addr4.sin_port = htons(8888);
    addr4.sin_addr.s_addr = htonl(INADDR_ANY);
    CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
    
    if (kCFSocketSuccess != CFSocketSetAddress(_socket, address)) {
        NSLog(@"Bind to address failed!");
        if (_socket)
            CFRelease(_socket);
        _socket = NULL;
        return 0;
    }
    
    CFRunLoopRef cfRunLoop = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
    CFRunLoopAddSource(cfRunLoop, source, kCFRunLoopCommonModes);
    CFRelease(source);
    
    return 1;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSocket];
    // Do any additional setup after loading the view.
    /*
    char *str = "nihao";
    if (self.outputStream != NULL) {
        CFWriteStreamWrite(self.outputStream, (const UInt8 * )str, strlen(str));
    } else {
        NSLog(@"Cannot send data!");
    }
     */
}


// socket回调函数，同客户端
void TCPServerAcceptCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
    if (kCFSocketAcceptCallBack == type) {
        // 本地套接字句柄
        CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle *)data;
        uint8_t name[SOCK_MAXADDRLEN];
        socklen_t nameLen = sizeof(name);
        if (0 != getpeername(nativeSocketHandle, (struct sockaddr *)name, &nameLen)) {
            NSLog(@"error");
            exit(1);
        }
        CFReadStreamRef inStream;
        CFWriteStreamRef outStream;
        // 创建一个可读写的socket连接
        CFStreamCreatePairWithSocket(kCFAllocatorDefault, nativeSocketHandle, &inStream, &outStream);
        if (inStream && outStream) {
            CFStreamClientContext streamContext = {0, NULL, NULL, NULL};
            
            if (!CFReadStreamSetClient(inStream, kCFStreamEventHasBytesAvailable,
                                       readStream, // 回调函数，当有可读的数据时调用
                                       &streamContext)){
                exit(1);
            }
            if (!CFWriteStreamSetClient(outStream, kCFStreamEventCanAcceptBytes,writeStream, &streamContext)){
                exit(1);
            }
            CFReadStreamScheduleWithRunLoop(inStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
            CFWriteStreamScheduleWithRunLoop(outStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
            CFReadStreamOpen(inStream);
            CFWriteStreamOpen(outStream);
        } else {
            close(nativeSocketHandle);
        }
    }
}
// 读取数据
void readStream(CFReadStreamRef stream, CFStreamEventType eventType, void *clientCallBackInfo) {
    UInt8 buff[255];
    CFReadStreamRead(stream, buff, 255);
    printf("received: %s", buff);
}

void writeStream(CFWriteStreamRef stream, CFStreamEventType type, void *clientCallBackInfo){
    //self.outputStream = stream;
    _outputStream = stream;
    
}
//主动输出函数
void writeMessage(NSString* str){
    
    const char * buff = [str cStringUsingEncoding:NSUTF8StringEncoding];
    if (_outputStream != NULL) {
        CFWriteStreamWrite(_outputStream, (const UInt8 *)buff, strlen(buff));
    }
}

/*
// 开辟一个线程线程函数中
void runLoopInThread() {
    int res = setupSocket();
    if (!res) {
        exit(1);
    }
    CFRunLoopRun();    // 运行当前线程的CFRunLoop对象
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
