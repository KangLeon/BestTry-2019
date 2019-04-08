//
//  FSCalenarView.m
//  XinSystem
//
//  Created by admin on 2018/10/18.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FSCalenarView.h"
#import <FSCalendar.h>

@interface FSCalenarView ()<FSCalendarDelegate,FSCalendarDataSource>
//值及工具
@property(nonatomic,strong)NSDateFormatter *dateFormatter;
@property(nonatomic,strong)NSString *dateString;

//View
@property(nonatomic,strong)FSCalendar *calendar_View;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *nav_View;
@property(nonatomic,strong)UIButton *cancelButton;

@end

@implementation FSCalenarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        self.layer.shadowRadius = 4;//阴影半径，默认3
        self.layer.cornerRadius=3.0;
    }
    return self;
}

-(void)addUI{
    self.backView=[[UIView alloc] initWithFrame:self.bounds];
    self.backView.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:self.backView];
    
    self.nav_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 40)];
    self.nav_View.backgroundColor=OLIVEGREEN;
    
    [self.backView addSubview:self.nav_View];
    
    self.cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(self.backView.frame.size.width-80, 1, 80, 38)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nav_View addSubview:self.cancelButton];
    
    self.calendar_View=[[FSCalendar alloc] initWithFrame:CGRectMake(0, 40, self.backView.frame.size.width, self.backView.frame.size.height-40)];
    self.calendar_View.backgroundColor=[UIColor whiteColor];
    self.calendar_View.dataSource=self;
    self.calendar_View.delegate=self;
    
    [self.backView addSubview:self.calendar_View];
}

-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.dateString = [self.dateFormatter stringFromDate:date];
    
    if (self.date_result_Block) {
        self.date_result_Block(self.dateString);
    }
}

-(void)cancelAction{
    if (self.cacel_result_Block) {
        self.cacel_result_Block();
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
