//
//  CandyAlert.m
//  KOOV
//
//  Created by 吉腾蛟 on 2018/12/27.
//  Copyright © 2018 Sony. All rights reserved.
//
// !!!:用运行时动态切换单例？

#import "CandyAlert.h"
#import "CandyAlertTop.h"

@interface CandyAlert ()
@property(nonatomic,strong)LOTAnimationView *lotAnimation_view;//动画
@property(nonatomic,strong)UIView *mask_view;//遮罩
@property(nonatomic,strong)UIView *back_view;//背景白色
@property(nonatomic,strong)UILabel *title_label;//提示文字

@property(nonatomic,strong)CandyAlertTop *alertTop;//顶部提示框
@end

@implementation CandyAlert
+(CandyAlert *)sharedCandyAlert{
    static CandyAlert *alert=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert=[[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return alert;
}
#pragma mark - 初始化UI
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.maskView];
        [self addSubview:self.back_view];
        [self addSubview:self.title_label];
        
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(SCREEN_HEIGHT);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back_view.mas_left).offset(SNTrueWidth(20));
            make.right.equalTo(self.back_view.mas_right).offset(SNTrueHeight(-20));
            make.bottom.equalTo(self.back_view.mas_bottom).offset(SNTrueHeight(-20));
            make.top.equalTo(self.back_view.mas_top).offset(SNTrueHeight(110));
        }];
        [self.back_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
#pragma mark - 懒加载
-(UILabel *)title_label{
    if (!_title_label) {
        _title_label=[[UILabel alloc] init];
        _title_label.textColor=TEXT_BLACK;
        _title_label.textAlignment=NSTextAlignmentCenter;
    }
    return _title_label;
}
-(UIView *)back_view{
    if (!_back_view) {
        _back_view=[[UIView alloc] init];
        _back_view.backgroundColor=[UIColor whiteColor];
        _back_view.layer.cornerRadius=20.0;
    }
    return _back_view;
}
-(UIView *)maskView{
    if (!_mask_view) {
        _mask_view=[[UIView alloc] init];
        _mask_view.backgroundColor=[UIColor blackColor];
        _mask_view.alpha=0.5;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(dismiss)];
        [_mask_view addGestureRecognizer:tap];
    }
    return _mask_view;
}
-(CandyAlertTop *)alertTop{
    if (!_alertTop) {
        _alertTop=[[CandyAlertTop alloc] initWithFrame:CGRectMake(0, SNTrueHeight(-130), SCREEN_WIDTH, SNTrueHeight(130))];
    }
    return _alertTop;
}
#pragma mark 简单的中间alert
+ (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedCandyAlert]];
    [self setAlphaAnimationWithTitle:nil];
}
+ (void)dismiss{
    [self setAnimationDismiss];
}
+(void)showWithTitle:(NSString *)title{
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedCandyAlert]];
    [self setAlphaAnimationWithTitle:title];
    [self setAnimationWithType:CandyAlertTypeLoading];
}
+(void)showErrorWithTitle:(NSString *)title{
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedCandyAlert]];
    [self setAlphaAnimationWithTitle:title];
    [self setAnimationWithType:CandyAlertTypeWarning];
}

+(void)dismissWithDelay:(NSInteger)second{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

//设置弹出alert动画类型
+(void)setAnimationWithType:(CandyAlertType)type{
    //清除所有动画
    for (UIView *view in [self sharedCandyAlert].subviews) {
        if ([view isKindOfClass:[LOTAnimationView class]]) {
            [view removeFromSuperview];
        }
    }
    [self sharedCandyAlert].lotAnimation_view=[[LOTAnimationView alloc] init];
    [self sharedCandyAlert].lotAnimation_view.loopAnimation=YES;
    [self sharedCandyAlert].lotAnimation_view.contentMode=UIViewContentModeScaleToFill;
    [self sharedCandyAlert].lotAnimation_view.animationSpeed=4.0;
    [self sharedCandyAlert].lotAnimation_view.userInteractionEnabled=NO;
    switch (type) {
        case CandyAlertTypeLoading:
        {
            [self sharedCandyAlert].lotAnimation_view=[LOTAnimationView animationNamed:@"bb8"];
            [[self sharedCandyAlert] addSubview:[self sharedCandyAlert].lotAnimation_view];
            [[self sharedCandyAlert].lotAnimation_view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SNTrueWidth(90));
                make.height.mas_equalTo(SNTrueHeight(90));
                make.centerX.equalTo([self sharedCandyAlert].mas_centerX);
                make.top.equalTo([self sharedCandyAlert].back_view.mas_top).offset(SNTrueHeight(10));
            }];
        }
            break;
        case CandyAlertTypeWarning:
        {
            [self sharedCandyAlert].lotAnimation_view=[LOTAnimationView animationNamed:@"warning_sign"];
            [[self sharedCandyAlert] addSubview:[self sharedCandyAlert].lotAnimation_view];
            
            [[self sharedCandyAlert].lotAnimation_view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SNTrueWidth(160));
                make.height.mas_equalTo(SNTrueHeight(120));
                make.centerX.equalTo([self sharedCandyAlert].mas_centerX);
                make.top.equalTo([self sharedCandyAlert].back_view.mas_top);
            }];
        }
            break;
            
        default:
            break;
    }
}

//设置透明度出现动画
+(void)setAlphaAnimationWithTitle:(NSString  * _Nullable)title{
    [self sharedCandyAlert].alpha=0.1;
    if (title) {
        [self sharedCandyAlert].title_label.text=title;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self sharedCandyAlert].alpha=1.0;
    } completion:^(BOOL finished) {
        [[self sharedCandyAlert].lotAnimation_view play];
    }];
}

//设置透明度消失动画
+(void)setAnimationDismiss{
    [UIView animateWithDuration:0.3 animations:^{
        [self sharedCandyAlert].alpha=0.1;
    } completion:^(BOOL finished) {
        [[self sharedCandyAlert] removeFromSuperview];
        [[self sharedCandyAlert].lotAnimation_view stop];
    }];
}

#pragma mark 上部alert

+ (void)showWarningWithTitle:(NSString *)title andDetailTitle:(NSString *)detail{
    [[self sharedCandyAlert].alertTop showWarningWithTitle:title andDetailTitle:detail];
}
+(void)showErrorWithTitle:(NSString *)title andDetailTitle:(NSString *)detail{
    [[self sharedCandyAlert].alertTop showErrorWithTitle:title andDetailTitle:detail];
}
+ (void)showInfoWithTitle:(NSString *)title andDetailTitle:(NSString *)detail{
    [[self sharedCandyAlert].alertTop showInfoWithTitle:title andDetailTitle:detail];
}
+(void)showSuccessWithTitle:(NSString *)title andDetailTitle:(NSString *)detail{
    [[self sharedCandyAlert].alertTop showSuccessWithTitle:title andDetailTitle:detail];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
