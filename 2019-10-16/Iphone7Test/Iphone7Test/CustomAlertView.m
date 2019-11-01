//
//  CustomAlertView.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/9/11.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "CustomAlertView.h"
#import <Masonry.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define FordTrueWidth(initialWidth) initialWidth*(SCREEN_WIDTH/414)
#define FordTrueHeight(initialHeight) initialHeight*(SCREEN_HEIGHT/896)
@interface CustomAlertView ()
//alert
@property(nonatomic,strong)UIView *mask_view;
@property(nonatomic,strong)UIView *back_view;
@property(nonatomic,strong)UIButton *alertLeft_button;
@property(nonatomic,strong)UIButton *alertRight_button;
@property(nonatomic,strong)UIView *vertical_line;
@property(nonatomic,strong)UIView *horizontal_line;
@end

@implementation CustomAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}
#pragma mark - 初始化UI
-(void)addUI{
    [self addSubview:self.mask_view];
    [self addSubview:self.back_view];
    
    [self updateConstraintsIfNeeded];
}
#pragma mark - 懒加载
-(UIView *)mask_view{
    if (!_mask_view) {
        _mask_view=[[UIView alloc] init];
        _mask_view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_mask_view addGestureRecognizer:tapGesture];
    }
    return _mask_view;
}
-(UIView *)back_view{
    if (!_back_view) {
        _back_view=[[UIView alloc] init];
        _back_view.backgroundColor=[UIColor colorWithRed:0.941 green:0.957 blue:0.969 alpha:1.00];
        _back_view.layer.cornerRadius=15.0;
        
        [_back_view addSubview:self.alertTitle_label];
        [_back_view addSubview:self.alertLeft_button];
        [_back_view addSubview:self.alertRight_button];
        [_back_view addSubview:self.vertical_line];
        [_back_view addSubview:self.horizontal_line];
    }
    return _back_view;
}
-(UILabel *)alertTitle_label{
    if (!_alertTitle_label) {
        _alertTitle_label=[[UILabel alloc] init];
        _alertTitle_label.textColor=[UIColor blackColor];
        _alertTitle_label.font=[UIFont systemFontOfSize:15.0];
        _alertTitle_label.textAlignment=NSTextAlignmentCenter;
        _alertTitle_label.text=@"是否确认分配任务给此二级经销商";
    }
    return _alertTitle_label;
}
-(UIButton *)alertLeft_button{
    if (!_alertLeft_button) {
        _alertLeft_button=[[UIButton alloc] init];
//        [_alertLeft_button setAttributedTitle:[NSMutableAttributedString noUnderLineText:@"取消"] forState:UIControlStateNormal];
        [_alertLeft_button setTitle:@"取消" forState:UIControlStateNormal];
        _alertLeft_button.backgroundColor=[UIColor clearColor];
        _alertLeft_button.titleLabel.font=[UIFont systemFontOfSize:17.0];
        [_alertLeft_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //取消按钮点击事件
//        [[_alertLeft_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            [self dismiss];
//        }];
    }
    return _alertLeft_button;
}
-(UIButton *)alertRight_button{
    if (!_alertRight_button) {
        _alertRight_button=[[UIButton alloc] init];
//        [_alertRight_button setAttributedTitle:[NSMutableAttributedString noUnderLineText:@"确定"] forState:UIControlStateNormal];
        [_alertRight_button setTitle:@"确定" forState:UIControlStateNormal];
        _alertRight_button.backgroundColor=[UIColor clearColor];
        _alertRight_button.titleLabel.font=[UIFont systemFontOfSize:17.0];
        [_alertRight_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //确定按钮点击事件
//        [[_alertRight_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            [self requestData];
//        }];
    }
    return _alertRight_button;
}
-(UIView *)vertical_line{
    if (!_vertical_line) {
        _vertical_line=[[UIView alloc] init];
        _vertical_line.backgroundColor=[UIColor grayColor];
    }
    return _vertical_line;
}
-(UIView *)horizontal_line{
    if (!_horizontal_line) {
        _horizontal_line=[[UIView alloc] init];
        _horizontal_line.backgroundColor=[UIColor grayColor];
    }
    return _horizontal_line;
}
#pragma mark - 代理

#pragma mark - target action
-(void)dismiss{
    [UIView animateWithDuration:0.4 animations:^{
        [self removeFromSuperview];
    }];
}
#pragma mark - Maonry
-(void)updateConstraints{
    [super updateConstraints];
    [self.mask_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    [self.back_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(116);
        make.width.mas_equalTo(248);
    }];
    
    [self.alertTitle_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.back_view);
        make.top.equalTo(self.back_view.mas_top).offset(20);
        make.height.mas_equalTo(29);
    }];
    [self.horizontal_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertTitle_label.mas_bottom).offset(20);
        make.left.right.equalTo(self.back_view);
        make.height.mas_equalTo(0.4);
    }];
    [self.alertLeft_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back_view.mas_left);
        make.top.equalTo(self.horizontal_line.mas_bottom);
        make.width.mas_equalTo(124);
        make.bottom.equalTo(self.back_view.mas_bottom);
    }];
    [self.vertical_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertLeft_button.mas_right);
        make.top.equalTo(self.horizontal_line.mas_bottom);
        make.bottom.equalTo(self.back_view.mas_bottom);
        make.width.mas_equalTo(0.6);
    }];
    [self.alertRight_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vertical_line.mas_right);
        make.top.equalTo(self.horizontal_line.mas_bottom);
        make.width.mas_equalTo(123.9);
        make.bottom.equalTo(self.back_view.mas_bottom);
    }];
}
#pragma mark - other 只有本页面会使用的工具方法
//-(void)requestData{
//    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
//    NSDictionary *param = [[NSMutableDictionary alloc] init];
//    [param setValue:self.idsNumber forKey:@"idsNumber"];
//    [param setValue:self.person_model.id forKey:@"subAccountId"];
//    [SVProgressHUD show];
//    [netTask postNetWorkRequestNoConstruct:[NSString stringWithFormat:@"%@/stage/allocationSubDealer",IDFordDomainName] needTookenFlag:YES para:param success:^(id successDic) {
//        NSLog(@"%@",successDic);
//
//        [SVProgressHUD showInfoWithStatus:@"申请件分配成功"];
////        DISSMISS
//        [self dismiss];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self dismiss];
//
//            if ([self.delegate respondsToSelector:@selector(closeDelagate)]) {
//                [self.delegate closeDelagate];
//            }
//        });
//
//    } failure:^(id failureDic) {
//        NSString *message = [failureDic objectForKey:@"message"];
//        [SVProgressHUD showInfoWithStatus:message];
//        DISSMISS
//        [self dismiss];
//    }];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
