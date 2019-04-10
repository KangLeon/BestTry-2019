//
//  DatePickerView.m
//  XinSystem
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView ()
//值及工具
@property(nonatomic,strong)NSDateFormatter *formatter;

//View
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *navBar;
@property(nonatomic,strong)UILabel *navTitle;
@property(nonatomic,strong)UIButton *completeButton;
@property(nonatomic,strong)UIDatePicker *mDatePicker;

@end

@implementation DatePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    //遮罩view
    self.maskView = [[UIView alloc]initWithFrame:self.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.3;
    [self addSubview:self.maskView];
    
    //导航控制器view
    self.backView=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-400)/2, SCREEN_HEIGHT, 400, 350)];
    self.backView.center=self.maskView.center;
    self.backView.backgroundColor=[UIColor whiteColor];
    self.backView.layer.cornerRadius=12.0;
    [self addSubview:self.backView];
    
    //导航条
    self.navBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 50)];
    self.navBar.backgroundColor=OLIVEGREEN;
    
    //!!!:其他页面也是需要进行贝塞尔曲线进行切割，怎么进行这个操作的复用？
    //贝塞尔曲线切割
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.navBar.bounds byRoundingCorners:UIRectCornerTopLeft |  UIRectCornerTopRight cornerRadii:CGSizeMake(12.0, 12.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.navBar.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.navBar.layer.mask = maskLayer;
    [self.backView addSubview:self.navBar];
    
    //导航条标题
    self.navTitle=[[UILabel alloc] initWithFrame:CGRectMake((400-100)/2, (50-35)/2, 100, 35)];
    self.navTitle.text=@"选择日期";
    self.navTitle.textColor=[UIColor whiteColor];
    self.navTitle.font=[UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium];
    self.navTitle.textAlignment=NSTextAlignmentCenter;
    [self.navBar addSubview:self.navTitle];
    
    //导航条完成item
    self.completeButton=[[UIButton alloc] initWithFrame:CGRectMake(400-70, (50-35)/2, 60, 35)];
    [self.completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeButton addTarget:self action:@selector(datePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:self.completeButton];
    
    self.mDatePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 400, 300)];
    [self.backView addSubview:self.mDatePicker];
    
    if (!self.formatter) {
        self.formatter= [[NSDateFormatter alloc] init];
    }
    
    self.formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.dateString=[self.formatter stringFromDate:[NSDate date]];
    
    //监听DataPicker的滚动
    [self.mDatePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark targer action

- (void)dateChange:(UIDatePicker *)datePicker {
    
    if (!self.formatter) {
        self.formatter= [[NSDateFormatter alloc] init];
    }
    //设置时间格式
    self.formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [self.formatter  stringFromDate:datePicker.date];
    
    self.dateString = dateStr;
}

//完成方法回调
-(void)datePicker{
    
    //RAC通知VC把值传给JS
    if (self.delegate!=nil) {
        if ([self.delegate respondsToSelector:@selector(dateStringToJs)]) {
            [self.delegate dateStringToJs];
        }
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
