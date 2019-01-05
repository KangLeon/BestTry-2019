//
//  CandyAlertTop.m
//  KOOV
//
//  Created by 吉腾蛟 on 2018/12/31.
//  Copyright © 2018 Sony. All rights reserved.
//

#import "CandyAlertTop.h"

@interface CandyAlertTop ()
//防止动画因为按钮被暴力点击多次而执行多次
@property(nonatomic,assign)BOOL isAnimation;
@end

@implementation CandyAlertTop

#pragma mark - 初始化UI
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=20.0;
        [self addSubview:self.first_label];
        [self addSubview:self.second_label];
        
        [self.first_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(SNTrueHeight(38));
            make.left.equalTo(self.mas_left).offset(SNTrueWidth(400));
            make.height.mas_equalTo(SNTrueHeight(40));
            make.right.equalTo(self.mas_right).offset(-SNTrueWidth(40));
        }];
        [self.second_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.first_label.mas_bottom).offset(SNTrueHeight(8));
            make.left.equalTo(self.mas_left).offset(SNTrueWidth(400));
            make.height.mas_equalTo(SNTrueHeight(35));
            make.right.equalTo(self.mas_right).offset(-SNTrueWidth(40));
        }];
    }
    return self;
}
#pragma mark - 懒加载
-(UILabel *)first_label{
    if (!_first_label) {
        _first_label=[[UILabel alloc] init];
        _first_label.textColor=[UIColor whiteColor];
        _first_label.textAlignment=NSTextAlignmentLeft;
        _first_label.font=[UIFont systemFontOfSize:20.0];
    }
    return _first_label;
}
-(UILabel *)second_label{
    if (!_second_label) {
        _second_label=[[UILabel alloc] init];
        _second_label.textColor=[UIColor whiteColor];
        _second_label.textAlignment=NSTextAlignmentLeft;
        _second_label.font=[UIFont systemFontOfSize:17.0];
    }
    return _second_label;
}

-(void)showInfoWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail{
    //设置主题颜色:
    self.backgroundColor=[UIColor whiteColor];
    self.first_label.textColor=TEXT_BLACK;
    self.second_label.textColor=TEXT_BLACK;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addLOTTopAnimtionWithName:@"emoji_empty" andTitle:title andDetailTitle:detail];
    //由于动画资源的尺寸不一样，所以需要在这里进行不同的布局约束
    [self.lotAnimationTop_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SNTrueHeight(180));
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(SNTrueWidth(260));
        make.height.mas_equalTo(SNTrueHeight(130));
    }];
    [self candyAlertTopAnimationBeginWithBlock];
}
-(void)showErrorWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail{
    self.backgroundColor=RGBA(236, 93, 110, 1.0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addLOTTopAnimtionWithName:@"emoji_uhoh" andTitle:title andDetailTitle:detail];
    [self.lotAnimationTop_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SNTrueHeight(250));
        make.top.equalTo(self.mas_top).offset(SNTrueHeight(0));
        make.width.mas_equalTo(SNTrueWidth(100));
        make.height.mas_equalTo(SNTrueHeight(180));
    }];
    [self candyAlertTopAnimationBeginWithBlock];
}
-(void)showWarningWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail{
    self.backgroundColor=RGBA(246, 166, 35, 1.0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addLOTTopAnimtionWithName:@"emoji_shock" andTitle:title andDetailTitle:detail];
    [self.lotAnimationTop_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SNTrueHeight(250));
        make.top.equalTo(self.mas_top).offset(SNTrueHeight(30));
        make.width.mas_equalTo(SNTrueWidth(100));
        make.height.mas_equalTo(SNTrueHeight(100));
    }];
    [self candyAlertTopAnimationBeginWithBlock];
}
-(void)showSuccessWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail{
    self.backgroundColor=RGBA(126, 211, 33, 1.0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addLOTTopAnimtionWithName:@"emoji_wink" andTitle:title andDetailTitle:detail];
    [self.lotAnimationTop_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SNTrueHeight(250));
        make.top.equalTo(self.mas_top).offset(SNTrueHeight(30));
        make.width.mas_equalTo(SNTrueWidth(100));
        make.height.mas_equalTo(SNTrueHeight(100));
    }];
    [self candyAlertTopAnimationBeginWithBlock];
}

//弹出顶部弹出框
-(void)candyAlertTopAnimationBeginWithBlock{
    [self.lotAnimationTop_view play];
    if (!self.isAnimation) {
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.isAnimation=YES;
            self.frame=CGRectMake(0, -(SNTrueHeight(30)), SCREEN_WIDTH, SNTrueHeight(130));
        } completion:^(BOOL finished) {
            [self dissmissCandyAlertTop];
        }];
    }
}

//顶部弹出框消失
-(void)dissmissCandyAlertTop{
    [UIView animateWithDuration:0.3 delay:3.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame=CGRectMake(0, SNTrueHeight(-130), SCREEN_WIDTH, SNTrueHeight(130));
    } completion:^(BOOL finished) {
        self.isAnimation=NO;
    }];
}

//根据动画名字添加动画
-(void)addLOTTopAnimtionWithName:(NSString *)string andTitle:(NSString *)title andDetailTitle:(NSString *)detail{
    //清除所有动画
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LOTAnimationView class]]) {
            [view removeFromSuperview];
        }
    }
    self.lotAnimationTop_view=[[LOTAnimationView alloc] init];
    self.lotAnimationTop_view.loopAnimation=YES;
    self.lotAnimationTop_view.contentMode=UIViewContentModeScaleToFill;
    self.lotAnimationTop_view.animationSpeed=2.0;
    self.lotAnimationTop_view.userInteractionEnabled=NO;
    self.lotAnimationTop_view=[LOTAnimationView animationNamed:string];
    
    [self addSubview:self.lotAnimationTop_view];
    
    self.first_label.text=title;
    self.second_label.text=detail;
}

@end

