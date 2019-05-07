//
//  AimImageCollectionViewCell.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/3/21.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "AimImageCollectionViewCell.h"

@interface AimImageCollectionViewCell ()

@end

@implementation AimImageCollectionViewCell
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
    [self addSubview:self.image_View];
    
    [self updateConstraintsIfNeeded];
}
#pragma mark - 懒加载
-(UIImageView *)image_View{
    if (!_image_View) {
        _image_View=[[UIImageView alloc] init];
        _image_View.image=[UIImage imageNamed:@"ic_picker_photo_black_48dp"];
        _image_View.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _image_View;
}
#pragma mark - 代理

#pragma mark - target action

#pragma mark - Maonry
-(void)updateConstraints{
    [super updateConstraints];
    [self.image_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(4);
        make.right.equalTo(self.mas_right).offset(-4);
        make.top.equalTo(self.mas_top).offset(4);
        make.bottom.equalTo(self.mas_bottom).offset(-4);
    }];
}
#pragma mark - other 只有本页面会使用的工具方法

@end
