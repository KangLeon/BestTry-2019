//
//  ViewController.m
//  ForLover
//
//  Created by admin on 2019/5/9.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>

@interface ViewController ()
@property(nonatomic,strong)LOTAnimationView *animation_view;
@property(nonatomic,strong)UILabel *content_label;
@property(nonatomic,strong)UIButton *next_label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.animation_view];
}

-(LOTAnimationView *)animation_view{
    if (!_animation_view) {
        _animation_view=[LOTAnimationView animationNamed:@"like"];
        _animation_view.frame=CGRectMake(0, 0, 200, 200);
        _animation_view.loopAnimation=false;
        _animation_view.contentMode=UIViewContentModeScaleToFill;
        _animation_view.animationSpeed=2.0;
        _animation_view.userInteractionEnabled=NO;
    }
    return _animation_view;
}

@end
