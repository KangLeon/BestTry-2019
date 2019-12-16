//
//  ViewController.m
//  TestViewWillAppear
//
//  Created by 吉腾蛟 on 2019/12/13.
//  Copyright © 2019 吉腾蛟. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)pushAction:(UIButton *)sender {
    SecondViewController *vc=[[SecondViewController alloc] init];
//    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"调用了");
}

@end
