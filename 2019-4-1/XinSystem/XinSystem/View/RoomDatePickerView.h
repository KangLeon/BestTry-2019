//
//  RoomDatePickerView.h
//  XinSystem
//
//  Created by admin on 2018/10/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoomDateStringBack <NSObject>

-(void)roomDateStringToJs;

@end

@interface RoomDatePickerView : UIView
@property(nonatomic,weak) id<RoomDateStringBack> delegate;
@property(nonatomic,strong)NSString *result_string;
@end
