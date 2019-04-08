//
//  TimePickerView.h
//  XinSystem
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^timeStringBack_Block)(NSString *);
typedef void(^timeStringCancel_Block)(void);

@interface TimePickerView : UIView
//值及工具
@property(nonatomic,strong)NSString *current_hour_minute;
@property(nonatomic,strong)NSString *timeString;
@property(nonatomic,copy)timeStringBack_Block time_string_back_block;
@property(nonatomic,copy)timeStringCancel_Block time_string_cancel_block;
-(void)addUI;
@end

NS_ASSUME_NONNULL_END
