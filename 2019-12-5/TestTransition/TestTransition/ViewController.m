//
//  ViewController.m
//  TestTransition
//
//  Created by 吉腾蛟 on 2019/12/17.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNumber *number=@(123124);
    NSNumber *emptynumber;
    
    if ([number boolValue]) {
        NSLog(@"number 不为空");
    }
    if (![emptynumber boolValue]) {
        NSLog(@"emptynumber 为空");
    }
}


@end
