//
//  CandyAlert.h
//  KOOV
//
//  Created by 吉腾蛟 on 2018/12/27.
//  Copyright © 2018 Sony. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CandyAlert : UIView
typedef NS_ENUM(NSUInteger, CandyAlertType) {
    CandyAlertTypeLoading,
    CandyAlertTypeWarning
};
/**
 不显示文字的加载框
 */
+ (void)show;

/**
 取消加载框
 */
+(void)dismiss;

/**
 带文字的加载框

 @param title 加载文字
 */
+(void)showWithTitle:(NSString *)title;

/**
 带文字的错误框

 @param title 错误提示文字
 */
+(void)showErrorWithTitle:(NSString *)title;

/**
 设置延时显示时间

 @param second 延时秒数
 */
+(void)dismissWithDelay:(NSInteger)second;

/**
 根据类型添加动画，类型有：
 Info:普通提示
 Error:错误
 Warning:警告
 Success:成功

 @param title 必须要有的主标题
 @param detail 可以为空的副标题
 */
+(void)showInfoWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;
+(void)showErrorWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;
+(void)showWarningWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;
+(void)showSuccessWithTitle:(NSString *)title andDetailTitle:(NSString * _Nullable)detail;
@end

NS_ASSUME_NONNULL_END
