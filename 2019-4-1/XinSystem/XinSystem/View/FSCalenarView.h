//
//  FSCalenarView.h
//  XinSystem
//
//  Created by admin on 2018/10/18.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dateResultBlock)(NSString *dateString);
typedef void(^cancelResultBlock)(void);

@interface FSCalenarView : UIView
@property(nonatomic,copy)dateResultBlock date_result_Block;
@property(nonatomic,copy)cancelResultBlock cacel_result_Block;
@end
