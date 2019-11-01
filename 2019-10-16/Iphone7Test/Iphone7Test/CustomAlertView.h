//
//  CustomAlertView.h
//  IDFord
//
//  Created by 吉腾蛟 on 2019/9/11.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PersonnelModel.h"

@protocol CustomAlertViewDelagate <NSObject>

-(void)closeDelagate;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView
@property(nonatomic,strong)UILabel *alertTitle_label;

//@property(nonatomic,strong)PersonnelModel *person_model;
@property(nonatomic,strong)NSNumber *idsNumber;

@property(nonatomic,weak)id<CustomAlertViewDelagate> delegate;

@end

NS_ASSUME_NONNULL_END
