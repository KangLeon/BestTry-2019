//
//  RoomDatePickerView.m
//  XinSystem
//
//  Created by admin on 2018/10/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "RoomDatePickerView.h"

@interface RoomDatePickerView ()<UITableViewDelegate,UITableViewDataSource>
//值及工具
@property(nonatomic,strong)NSDateFormatter *formatter;
@property(nonatomic,strong)NSString *string_start;
@property(nonatomic,strong)NSString *string_end;
@property(nonatomic,strong)NSIndexPath *index_path;

//View
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *finishButton;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIDatePicker *datePicker;
@end

@implementation RoomDatePickerView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    if (!self.formatter) {
        self.formatter= [[NSDateFormatter alloc] init];
    }
    
    self.formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.string_start=[self.formatter stringFromDate:[NSDate date]];
    
    self.formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date=[NSDate date];
    NSTimeInterval timeInterval=60*60;
    NSDate *afterDate=[NSDate dateWithTimeInterval:timeInterval sinceDate:date];
    self.string_end=[self.formatter stringFromDate:afterDate];
    
    self.maskView=[[UIView alloc] initWithFrame:self.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.3;
    [self addSubview:self.maskView];
    
    self.backView=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-400)/2, (SCREEN_HEIGHT-500)/2, 400, 400)];
    self.backView.backgroundColor=[UIColor whiteColor];
    self.backView.layer.cornerRadius=12.0;
    [self addSubview:self.backView];//不可以加在maskView上面，会让子View也会有透明度，
    
    self.navView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 50)];
    self.navView.backgroundColor=OLIVEGREEN;
    
    //贝塞尔曲线切割
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.navView.bounds byRoundingCorners:UIRectCornerTopLeft |  UIRectCornerTopRight cornerRadii:CGSizeMake(12.0, 12.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.navView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.navView.layer.mask = maskLayer;
    
    [self.backView addSubview:self.navView];
    
    self.cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 35)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.cancelButton];
    
    self.finishButton=[[UIButton alloc] initWithFrame:CGRectMake(400-10-60, 10, 60, 35)];
    [self.finishButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.finishButton];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 400, 100)];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.backView addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseCell"];
    }
    if (indexPath.row==0) {
        cell.textLabel.text=@"开始时间";
       
        cell.detailTextLabel.text=self.string_start;
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"结束时间";
        
        cell.detailTextLabel.text=self.string_end;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (UIView *view in self.backView.subviews) {
        if ([view isEqual:self.datePicker]) {
            [view removeFromSuperview];
        }
    }
    self.index_path=indexPath;
    //点击弹出时间选取器
    self.datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 150, 400, 250)];
    [self.backView addSubview:self.datePicker];
    
    [self.datePicker addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark target-action
-(void)cancelSelect{
    if (self.delegate!=nil) {
        if ([self.delegate respondsToSelector:@selector(roomDateStringToJs)]) {
            [self.delegate roomDateStringToJs];
        }
    }
}

//完成方法回调
-(void)finishSelect{
    
    self.result_string=[NSString stringWithFormat:@"%@*%@",self.string_start,self.string_end];
    
    if (self.delegate!=nil) {
        if ([self.delegate respondsToSelector:@selector(roomDateStringToJs)]) {
            [self.delegate roomDateStringToJs];
        }
    }
}

//日期选取器回调
- (void)dateSelect:(UIDatePicker *)datePicker {
    
    if (!self.formatter) {
        self.formatter= [[NSDateFormatter alloc] init];
    }
    //设置时间格式
    self.formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [self.formatter  stringFromDate:datePicker.date];
    
    //判断是哪个cell然后进行赋值
    if (self.index_path.row==0) {
        self.string_start=dateStr;
    }else{
        self.string_end=dateStr;
    }
    [self.tableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
