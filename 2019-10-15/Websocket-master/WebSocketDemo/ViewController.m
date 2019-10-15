//
//  ViewController.m
//  WebSocketDemo
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 ACJT. All rights reserved.
//

#import "ViewController.h"
#import "SocketRocketUtility.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SocketRocketUtility *rocket = [SocketRocketUtility instance];
    [rocket SRWebSocketOpen];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view, typically from a nib.
    rocket.didReceiveMessage = ^(id message) {
        NSLog(@"%@", message);
    };
}

- (void)sendMessage{
    SocketRocketUtility *rocket = [SocketRocketUtility instance];
    NSDictionary *dic = @{@"222":@"333"};
    [rocket sendData:dic withRequestURI:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
