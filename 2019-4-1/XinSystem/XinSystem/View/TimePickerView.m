//
//  TimePickerView.m
//  XinSystem
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 admin. All rights reserved.
//

#import "TimePickerView.h"

@interface TimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

//View
@property(nonatomic,strong)UIView *back_View;
@property(nonatomic,strong)UIPickerView *time_PickerView;//双滚轮的选取器
@property(nonatomic,strong)NSMutableArray *hour_array;
@property(nonatomic,strong)NSMutableArray *minute_array;
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *minute;

@end

@implementation TimePickerView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //初始化操作
        //        [self addUI];
        self.hour=@"00";
        self.minute=@"00";
    }
    return self;
}

#pragma UI初始化

-(void)addUI{
    //底层VIew
    self.back_View=[[UIView alloc] initWithFrame:self.bounds];
    self.back_View.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.back_View];
    
    //Nav
    UIView *nav=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    nav.backgroundColor=OLIVEGREEN;
    
    UIButton *cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(12.5, 12.5, 100, 30)];
    cancelButton.backgroundColor=[UIColor clearColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius=12.0;
    [cancelButton addTarget:self action:@selector(cancelTime) forControlEvents:UIControlEventTouchUpInside];
    
    [nav addSubview:cancelButton];
    
    UIButton *finishButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100-12.5, 12.5, 100, 30)];
    finishButton.backgroundColor=[UIColor clearColor];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishButton.layer.cornerRadius=12.0;
    [finishButton addTarget:self action:@selector(finishButton) forControlEvents:UIControlEventTouchUpInside];
    
    [nav addSubview:finishButton];
    
    [self.back_View addSubview:nav];
    
    //picker
    self.time_PickerView=[[UIPickerView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 55, 300, 400-55)];
    self.time_PickerView.backgroundColor=[UIColor clearColor];
    self.time_PickerView.delegate=self;
    self.time_PickerView.dataSource=self;
    
    [self.back_View addSubview:self.time_PickerView];
    if (self.current_hour_minute.length>1) {
        NSString *string_hour=[self.current_hour_minute substringWithRange:NSMakeRange(0, 2)];
        NSString *string_minute=[self.current_hour_minute substringWithRange:NSMakeRange(3, 2)];
        for (int i=0; i<24; i++) {
            if ([string_hour isEqualToString:self.hour_array[i]]) {
                [self.time_PickerView selectRow:i inComponent:0 animated:YES];
                self.hour=self.hour_array[i];
            }
        }
        for (int i=0; i<60; i++) {
            if ([string_minute isEqualToString:self.minute_array[i]]) {
                [self.time_PickerView selectRow:i inComponent:1 animated:YES];
                self.minute=self.minute_array[i];
            }
        }
    }
}

#pragma mark - 懒加载

-(NSMutableArray *)hour_array{
    if (!_hour_array) {
        _hour_array=[[NSMutableArray alloc] initWithCapacity:24];
        for (int i=0; i<24; i++) {
            NSString *string=[NSString stringWithFormat:@"%d",i];
            if (string.length<2) {
                //在前面补一个0
                NSMutableString *string_insert=[NSMutableString stringWithFormat:@"0"];
                string=[string_insert stringByAppendingString:string];
            }
            [_hour_array addObject:string];
        }
    }
    return _hour_array;
}
-(NSMutableArray *)minute_array{
    if (!_minute_array) {
        _minute_array=[[NSMutableArray alloc] initWithCapacity:60];
        for (int i=0; i<60; i++) {
            NSString *string=[NSString stringWithFormat:@"%d",i];
            if (string.length<2) {
                //在前面补一个0
                NSMutableString *string_insert=[NSMutableString stringWithFormat:@"0"];
                string=[string_insert stringByAppendingString:string];
            }
            [_minute_array addObject:string];
        }
    }
    return _minute_array;
}

#pragma mark 代理与数据源

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return 24;
    }
    else if(component==1){
        return 60;
    }
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return  self.hour_array[row];
    }else if (component==1){
        return self.minute_array[row];
    }
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        self.hour=self.hour_array[row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    else if (component==1){
        self.minute=self.minute_array[row];
    }
}

#pragma mark target-action

-(void)finishButton{
    //RAC通知VC把值传给JS
    self.timeString=[NSString stringWithFormat:@"%@:%@",self.hour,self.minute];
    if (self.time_string_back_block) {
        self.time_string_back_block(self.timeString);
    }
}

-(void)cancelTime{
    //RAC通知VC把值传给JS
    if(self.time_string_cancel_block){
        self.time_string_cancel_block();
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
