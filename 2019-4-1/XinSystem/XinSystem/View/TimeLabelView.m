//
//  TimeLabelView.m
//  XinSystem
//
//  Created by admin on 2018/10/17.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "TimeLabelView.h"

@interface TimeLabelView ()
//View
@property(nonatomic,strong)UIView *backView;

@end

@implementation TimeLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    
    self.backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 65)];
    self.backView.backgroundColor=OLIVEGREEN;
    self.backView.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.backView.layer.shadowOffset = CGSizeMake(3,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.backView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.backView.layer.shadowRadius = 2;//阴影半径，默认3
    self.backView.layer.cornerRadius=3.0;
    
    
    [self addSubview:self.backView];
    
    self.timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 25)];
    self.timeLabel.textAlignment=NSTextAlignmentLeft;
    self.timeLabel.textColor=[UIColor whiteColor];
    self.timeLabel.text=@"00:00";
    self.timeLabel.font=[UIFont systemFontOfSize:13.0 weight:UIFontWeightMedium];
    
    [self.backView addSubview:self.timeLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
