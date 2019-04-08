//
//  MoneyPickerView.m
//  XinSystem
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MoneyPickerView.h"

@interface MoneyPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>


//View
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIPickerView *moneyPickerView;//单滚轮的选取器
@end

@implementation MoneyPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //初始化操作
//        [self addUI];
    }
    return self;
}

#pragma UI初始化

-(void)addUI{
    //底层VIew
    self.backView=[[UIView alloc] initWithFrame:self.bounds];
    self.backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.backView];
    
    //Nav
    UIView *nav=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    nav.backgroundColor=OLIVEGREEN;
    
    UIButton *cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(12.5, 12.5, 100, 30)];
    cancelButton.backgroundColor=[UIColor clearColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius=12.0;
    [cancelButton addTarget:self action:@selector(cancelMoney) forControlEvents:UIControlEventTouchUpInside];
    
    [nav addSubview:cancelButton];
    
    UIButton *finishButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100-12.5, 12.5, 100, 30)];
    finishButton.backgroundColor=[UIColor clearColor];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishButton.layer.cornerRadius=12.0;
    [finishButton addTarget:self action:@selector(finishButton) forControlEvents:UIControlEventTouchUpInside];
    
    [nav addSubview:finishButton];
    
    [self.backView addSubview:nav];
    
    //picker
    self.moneyPickerView=[[UIPickerView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-400)/2, 55, 400, 400-55)];
    self.moneyPickerView.backgroundColor=[UIColor clearColor];
    self.moneyPickerView.delegate=self;
    self.moneyPickerView.dataSource=self;
    
    [self.backView addSubview:self.moneyPickerView];
    
}

#pragma mark 代理与数据源

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.moneyArray.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 300;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.moneyArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.moneyString=[NSString stringWithFormat:@"%ld",(long)row];
}

#pragma mark target-action

-(void)finishButton{
    
    //RAC通知VC把值传给JS
    if (self.delegate!=nil) {
        if ([self.delegate respondsToSelector:@selector(moneyStringToJs)]) {
            [self.delegate moneyStringToJs];
        }
    }
}

-(void)cancelMoney{
    //RAC通知VC把值传给JS
    if (self.delegate!=nil) {
        if ([self.delegate respondsToSelector:@selector(cancelMoneyStringToJS)]) {
            [self.delegate cancelMoneyStringToJS];
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
