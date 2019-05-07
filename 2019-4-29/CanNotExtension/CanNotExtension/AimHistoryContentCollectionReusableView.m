//
//  AimHistoryContentCollectionReusableView.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/3/21.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "AimHistoryContentCollectionReusableView.h"

@interface AimHistoryContentCollectionReusableView ()

@end

@implementation AimHistoryContentCollectionReusableView
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
    [self addSubview:self.title_label];
    
    [self updateConstraintsIfNeeded];
}
#pragma mark - 懒加载
-(UILabel *)title_label{
    if (!_title_label) {
        _title_label=[[UILabel alloc] init];
        _title_label.text=@"共同借款人身份证明";
        _title_label.textColor=[UIColor grayColor];
        _title_label.textAlignment=NSTextAlignmentLeft;
    }
    return _title_label;
}
#pragma mark - 代理

#pragma mark - target action

#pragma mark - Maonry
-(void)updateConstraints{
    [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [super updateConstraints];
}
#pragma mark - other 只有本页面会使用的工具方法
@end
