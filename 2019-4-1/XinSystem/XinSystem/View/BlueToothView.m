//
//  BlueToothView.m
//  XinSystem
//
//  Created by admin on 2018/11/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import "BlueToothView.h"

@interface BlueToothView ()
@end

@implementation BlueToothView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    UIView *maskView=[[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor=[UIColor blackColor];
    maskView.alpha=0.3;
    [self addSubview:maskView];
    
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, (SCREEN_HEIGHT-400)/2, 300, 400)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.cornerRadius=12.0;
    [self addSubview:backView];
    
    UIView *navBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, 50)];
    navBar.backgroundColor=OLIVEGREEN;
    
    //!!!:其他页面也是需要进行贝塞尔曲线进行切割，怎么进行这个操作的复用？
    //贝塞尔曲线切割
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:navBar.bounds byRoundingCorners:UIRectCornerTopLeft |  UIRectCornerTopRight cornerRadii:CGSizeMake(12.0, 12.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = navBar.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    navBar.layer.mask = maskLayer;
    [backView addSubview:navBar];
    
    [backView addSubview:self.tableView];
    [navBar addSubview:self.cancel_button];
    [navBar addSubview:self.print_button];
    
    UILabel *title_label=[[UILabel alloc] initWithFrame:CGRectMake((300-100)/2, 5, 100, 40)];
    title_label.text=@"蓝牙列表";
    title_label.textColor=[UIColor whiteColor];
    title_label.textAlignment=NSTextAlignmentCenter;
    
    [navBar addSubview:title_label];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 300, 350)];
        _tableView.backgroundColor=[UIColor clearColor];
    }
    return _tableView;
}

-(UIButton *)cancel_button{
    if (!_cancel_button) {
        _cancel_button=[[UIButton alloc] initWithFrame:CGRectMake(5, 5, 80, 40)];
        _cancel_button.backgroundColor=[UIColor clearColor];
        [_cancel_button setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancel_button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel_button;
}

-(UIButton *)print_button{
    if (!_print_button) {
        _print_button=[[UIButton alloc] initWithFrame:CGRectMake((300-90), 5, 80, 40)];
        _print_button.backgroundColor=[UIColor clearColor];
        [_print_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_print_button setTitle:@"打印" forState:UIControlStateNormal];
        [_print_button addTarget:self action:@selector(printAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _print_button;
}

-(void)cancelAction{
    if (self.cancel_block) {
        self.cancel_block();
    }
}

-(void)printAction{
    if (self.print_button) {
        self.print_block();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
