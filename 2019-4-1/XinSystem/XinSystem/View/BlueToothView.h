//
//  BlueToothView.h
//  XinSystem
//
//  Created by admin on 2018/11/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelBlock)(void);
typedef void(^printBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface BlueToothView : UIView
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *cancel_button;
@property(nonatomic,strong)UIButton *print_button;

@property(nonatomic,copy)cancelBlock cancel_block;
@property(nonatomic,copy)printBlock print_block;
@end

NS_ASSUME_NONNULL_END
