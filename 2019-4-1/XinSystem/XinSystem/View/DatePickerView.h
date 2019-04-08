//
//  DatePickerView.h
//  XinSystem
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateStringBack <NSObject>

-(void)dateStringToJs;

@end

@interface DatePickerView : UIView

@property(nonatomic,strong)NSString *dateString;
@property(nonatomic,weak) id<DateStringBack> delegate;

@end
