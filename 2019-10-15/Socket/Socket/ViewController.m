//
//  ViewController.m
//  Socket
//
//  Created by 吉腾蛟 on 2019/10/15.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
@import CocoaAsyncSocket;

@interface ViewController ()<GCDAsyncSocketDelegate>
@property(strong,nonatomic)GCDAsyncSocket *clientSocket;
 // 计时器
@property (nonatomic, strong) NSTimer *connectTimer;

@property(nonatomic,assign)BOOL connected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *error = nil;
    self.connected = [self.clientSocket connectToUrl:[NSURL URLWithString:@"wss://weixin.csmc-cloud.com/livehappyprd/wss/exercise-server/barrageCenter/socket/123456789"] withTimeout:-1 error:&error];
    if (error) {
        NSLog(@"有错发生");
    }
    NSLog(@"");
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接主机对应端口%@", sock);
    
    // 连接成功开启定时器
    [self addTimer];
    // 连接后,可读取服务端的数据
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
    self.connected = YES;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url{
    NSLog(@"连接主机对应端口%@", sock);
}

// 添加定时器
- (void)addTimer
{
     // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
     // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}

// 心跳连接
- (void)longConnectToSocket
{
    // 发送固定格式的数据,指令@"longConnect"
    float version = [[UIDevice currentDevice] systemVersion].floatValue;
    NSString *longConnect = [NSString stringWithFormat:@"123%f",version];
    
    NSData  *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}
@end
