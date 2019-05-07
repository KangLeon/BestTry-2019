//
//  FileUploadOutsiderHeaderView.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "FileUploadOutsiderHeaderView.h"

@interface FileUploadOutsiderHeaderView ()
@property(nonatomic,strong)UIView *seperator_view;

@property(nonatomic,strong)UIView *line_view;
@end

@implementation FileUploadOutsiderHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self addUI];
        
        [RACObserve(_aimsStatus_Label, text) subscribeNext:^(NSString *  _Nullable x) {
            if ([x isEqualToString:@"接收失败"]) {
                self.retry_button.hidden=NO;
            }else{
                self.retry_button.hidden=YES;
            }
        }];
    }
    return self;
}
#pragma mark - 初始化UI
-(void)addUI{
    [self addSubview:self.seperator_view];
    [self addSubview:self.date_label];
    [self addSubview:self.aimsStatus_Label];
    [self addSubview:self.line_view];
    [self addSubview:self.retry_button];
    
    [self updateConstraintsIfNeeded];
}
#pragma mark - 懒加载
-(UIView *)seperator_view{
    if (!_seperator_view) {
        _seperator_view=[[UIView alloc] init];
        _seperator_view.backgroundColor=[UIColor colorWithRed:0.941 green:0.957 blue:0.969 alpha:1.00];
    }
    return _seperator_view;
}
-(UILabel *)date_label{
    if (!_date_label) {
        _date_label=[[UILabel alloc] init];
        //        _date_label.text=@"2019.03.20";
        _date_label.textColor=TEXT_BLACK_BLUE;
        _date_label.textAlignment=NSTextAlignmentLeft;
    }
    return _date_label;
}
-(UILabel *)aimsStatus_Label{
    if (!_aimsStatus_Label) {
        _aimsStatus_Label=[[UILabel alloc] init];
        //        _aimsStatus_Label.text=@"接受成功";
        _aimsStatus_Label.textColor=TEXT_BLACK_BLUE;
        _aimsStatus_Label.textAlignment=NSTextAlignmentRight;
    }
    return _aimsStatus_Label;
}
-(UIView *)line_view{
    if (!_line_view) {
        _line_view=[[UIView alloc] init];
        _line_view.backgroundColor=[UIColor grayColor];
    }
    return _line_view;
}
-(UIButton *)retry_button{
    if (!_retry_button) {
        _retry_button=[[UIButton alloc] init];
        _retry_button.layer.cornerRadius=15;
        if (IS_FORD_OR_LINCOLN) {
            _retry_button.backgroundColor=[UIColor colorWithRed:184/255.0 green:97/255.0 blue:36/255.0 alpha:1.0];
        }else{
            _retry_button.backgroundColor=[UIColor colorWithRed:4/255.0 green:117/255.0 blue:218/255.0 alpha:1.0];
        }
        [_retry_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        NSMutableAttributedString *string=[[NSMutableAttributedString alloc] initWithString:@"重新发送"];
        [string addAttribute:NSUnderlineStyleAttributeName
                       value:@(NSUnderlineStyleNone)
                       range:(NSRange){0,[string length]}];
        [string addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:14.0]
                       range:(NSRange){0,[string length]}];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:(NSRange){0,[string length]}];
        
        [_retry_button setAttributedTitle:string forState:UIControlStateNormal];
        
        [_retry_button setTitle:@"重新发送" forState:UIControlStateNormal];
    }
    return _retry_button;
}
#pragma mark - 代理

#pragma mark - target action

#pragma mark - Maonry
-(void)updateConstraints{
    [super updateConstraints];
    [self.seperator_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    [self.date_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.seperator_view.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(150);
    }];
    [self.aimsStatus_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.seperator_view.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.retry_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.aimsStatus_Label.mas_left).offset(-5);
        make.centerY.equalTo(self.aimsStatus_Label.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(1.0);
    }];
}
#pragma mark - other 只有本页面会使用的工具方法
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
