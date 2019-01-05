//
//  CandyAlertTop.h
//  KOOV
//
//  Created by 吉腾蛟 on 2018/12/31.
//  Copyright © 2018 Sony. All rights reserved.
//

#import "CandyAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface CandyAlertTop : UIView
@property(nonatomic,strong)LOTAnimationView *lotAnimationTop_view;
@property(nonatomic,strong)UILabel *first_label;
@property(nonatomic,strong)UILabel *second_label;


/**
 普通提示

 @param title 标题
 @param detail 细节
 */
-(void)showInfoWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;

/**
 错误提示

 @param title 标题
 @param detail 细节
 */
-(void)showErrorWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;

/**
 警告提示

 @param title 标题
 @param detail 细节
 */
-(void)showWarningWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;

/**
 成功

 @param title 标题
 @param detail 细节
 */
-(void)showSuccessWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;
@end

NS_ASSUME_NONNULL_END
