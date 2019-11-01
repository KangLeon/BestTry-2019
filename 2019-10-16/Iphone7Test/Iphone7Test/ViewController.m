//
//  ViewController.m
//  Iphone7Test
//
//  Created by 吉腾蛟 on 2019/10/17.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property(nonatomic,strong)CustomAlertView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(CustomAlertView *)alertView{
    if (!_alertView) {
        _alertView=[[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _alertView.delegate=self;
    }
    return _alertView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}

@end
