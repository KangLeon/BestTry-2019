//
//  ViewController.m
//  ForLover
//
//  Created by admin on 2019/5/9.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>
#import <ReactiveObjC.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property(nonatomic,strong)LOTAnimationView *animation_view;
@property(nonatomic,strong)UILabel *content_label;
@property(nonatomic,strong)UIButton *next_button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0 green:217/255.0 blue:201/255.0 alpha:1.0];
}

-(UILabel *)content_label{
    if (!_content_label) {
        _content_label=[[UILabel alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, SCREEN_HEIGHT-355)];
        _content_label.backgroundColor=[UIColor clearColor];
        _content_label.textColor=[UIColor colorWithRed:225/255.0 green:158/255.0 blue:142/255.0 alpha:1.0];
        _content_label.font=[UIFont systemFontOfSize:20.0];
        _content_label.textAlignment=NSTextAlignmentCenter;
        _content_label.text=@"我给你讲一个故事";
        _content_label.numberOfLines=20.0;
        _content_label.alpha=0;
    }
    return _content_label;
}

-(LOTAnimationView *)animation_view{
    if (!_animation_view) {
        _animation_view=[LOTAnimationView animationNamed:@"微信消息"];
        _animation_view.frame=CGRectMake((SCREEN_WIDTH-200)/2, 600, 200, 200);
        _animation_view.center=CGPointMake(self.view.center.x, 700);
        _animation_view.loopAnimation=YES;
        _animation_view.contentMode=UIViewContentModeScaleToFill;
        _animation_view.animationSpeed=2.0;
        _animation_view.userInteractionEnabled=NO;
        _animation_view.alpha=0;
    }
    return _animation_view;
}

-(UIButton *)next_button{
    if (!_next_button) {
        _next_button=[[UIButton alloc] initWithFrame:CGRectMake(80, SCREEN_HEIGHT-200, SCREEN_WIDTH-160, 55)];
        _next_button.backgroundColor=[UIColor colorWithRed:225/255.0 green:158/255.0 blue:142/255.0 alpha:1.0];
        _next_button.layer.cornerRadius=55/2;
        _next_button.alpha=0.0;
        [_next_button setTitle:@"Next" forState:UIControlStateNormal];
    }
    return _next_button;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //开始动画显示内容，
    [self.view addSubview:self.content_label];
    [self.view addSubview:self.animation_view];
    [UIView animateWithDuration:2.0 animations:^{
        self.content_label.alpha=1.0;
    } completion:^(BOOL finished) {
        
    }];
    
    //2. 文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"22年前的今天，一位小仙女来到这个世界";
            
        }];
    });
    

    //3. 显示文字：
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //4. 文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"她的名字叫：郁梦莹";
        }];
    });

    //5. 再次显示文字：
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });

    //6.文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"2019-4-12日，在这个幸运的日子里，我遇到了她，她是那么的美好、可爱、漂亮，让人喜爱又有些不忍触碰，生怕伤害到她的美好";
        }];
    });
    
    //7. 再次显示文字：
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //8.文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(14.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"控制不住的喜欢她，迷恋她，忍不住看她";
        }];
    });
    
    //9.再次显示文字：
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(16.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //10.文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(18.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"后来幸运到了极致，我们恋爱了，想感谢god，想感谢一切，感谢让她来到了我身边。";
        }];
    });
    
    //11. 再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //12.文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(22.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"今天是她的生日，我想祝她生日快乐，可以像孩子一样每天都那么快乐；也祝她越来越美丽，是世界上最美的人；也希望她的往后的生活中都有我，让我作她的英雄，只让她看到美好的东西，因为小可爱就要享受这个世界的美好。";
        }];
    });
    
    //13. 再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(24.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //14.文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(26.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"你问我喜欢她什么？";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(28.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"喜欢一个人是很难说清楚的，但是我想这样解释给你听";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(32.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(34.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            self.content_label.text=@"喜欢她，是当她发来信息时";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(36.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(38.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"心就怦怦跳";
            self.animation_view.animation=@"心跳";
        }];
    });
    
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(40.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(42.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"喜欢就是想要抱着她，当抱着她的时候，心里有稳稳的一种感觉在涌动";
            self.animation_view.animation=@"温温的东西";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(44.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(46.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"喜欢就是很期待约会的日子早点到来";
            self.animation_view.animation=@"日历";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(48.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(50.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"喜欢也是想要陪她去吃喜欢的冰淇淋";
            self.animation_view.animation=@"冰淇淋";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(52.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(54.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"陪她去吃好吃的面包";
            self.animation_view.animation=@"牛角面包";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(56.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(58.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"陪她去喝咖啡";
            self.animation_view.animation=@"咖啡";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(62.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"陪她去读书";
            self.animation_view.animation=@"读书";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(64.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(66.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"陪她去吃披萨";
            self.animation_view.animation=@"披萨";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(68.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(70.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"陪她去喝一点小酒";
            self.animation_view.animation=@"啤酒";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(72.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(74.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"陪她去旅游";
            self.animation_view.animation=@"骑自行车旅游";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(76.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(78.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"养一只小狗";
            self.animation_view.animation=@"小狗";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(80.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
    
    //文字消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(82.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=0.0;
            self.content_label.alpha=0;
        } completion:^(BOOL finished) {
            [self.animation_view stop];
            self.content_label.text=@"养一只小猫";
            self.animation_view.animation=@"小猫";
        }];
    });
    
    //再次显示文字
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(84.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.animation_view.alpha=1.0;
            self.content_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [self.animation_view play];
        }];
    });
}

@end
