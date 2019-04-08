//
//  CuteAlert.m
//  XinSystem
//
//  Created by admin on 2018/11/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import "CuteAlert.h"

@interface CuteAlert ()
@property(nonatomic,strong)UIView *back_view;
@property(nonatomic,strong)UILabel *title_label;
@end

@implementation CuteAlert


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)showAlert:(NSString *)info{
    self.title_label.text=info;
    [UIView animateWithDuration:0.4 animations:^{
    self.back_view.center=CGPointMake(self.back_view.center.x,self.back_view.center.y+self.back_view.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.back_view.center=CGPointMake(self.back_view.center.x, self.back_view.center.y-self.back_view.frame.size.height);
        } completion:nil];
    }];
}

-(void)addUI{
    self.back_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.back_view.backgroundColor=TIMEBLUE;
    
    [self addSubview:self.back_view];
    
    self.title_label=[[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 60)];
    self.title_label.text=@"";
    self.title_label.textColor=[UIColor whiteColor];
    self.title_label.textAlignment=NSTextAlignmentCenter;
    
    [self.back_view addSubview:self.title_label];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
