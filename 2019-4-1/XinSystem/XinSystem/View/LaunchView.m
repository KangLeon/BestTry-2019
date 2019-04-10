//
//  LaunchView.m
//  XinSystem
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 admin. All rights reserved.
//
//Description:遮羞布View
//vue工程加载非常慢，不是iOS这边问题。

#import "LaunchView.h"

@interface LaunchView ()

@property(nonatomic,strong)UIImageView *background_image_view;
@property(nonatomic,strong)UIImageView *logo_image_view;
@property(nonatomic,strong)UIActivityIndicatorView *indicator_view;

@end

@implementation LaunchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    [self addSubview:self.background_image_view];
    [self addSubview:self.logo_image_view];
    [self addSubview:self.indicator_view];
}

-(UIImageView *)background_image_view{
    if (!_background_image_view) {
        _background_image_view=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _background_image_view.image=[UIImage imageNamed:@"logoVC_bg4"];
    }
    return _background_image_view;
}
-(UIImageView *)logo_image_view{
    if (!_logo_image_view) {
        _logo_image_view=[[UIImageView alloc] initWithFrame:CGRectMake(0,0 , 300/SCREEN_WIDTH*SCREEN_WIDTH, 300/SCREEN_HEIGHT*SCREEN_HEIGHT)];
        _logo_image_view.center=self.center;
        _logo_image_view.image=[UIImage imageNamed:@"loginVC_logo3"];
    }
    return _logo_image_view;
}
-(UIActivityIndicatorView *)indicator_view{
    if (!_indicator_view) {
        _indicator_view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator_view.center=CGPointMake(self.center.x, self.center.y+150);
        _indicator_view.backgroundColor=[UIColor clearColor];
        [_indicator_view startAnimating];
    }
    return _indicator_view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
