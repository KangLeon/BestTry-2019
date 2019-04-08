//
//  MoneyPickerView.h
//  XinSystem
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoneyStringBack <NSObject>

-(void)moneyStringToJs;
-(void)cancelMoneyStringToJS;

@end

@interface MoneyPickerView : UIView
//值及工具
@property(nonatomic,strong)NSMutableArray *moneyArray;
@property(nonatomic,strong)NSString *moneyString;
@property(nonatomic,weak)id<MoneyStringBack> delegate;
-(void)addUI;
@end
