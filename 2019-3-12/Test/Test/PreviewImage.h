//
//  PreviewImage.h
//  KOOV
//
//  Created by 吉腾蛟 on 2019/3/13.
//  Copyright © 2019 Sony. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreviewImage : UIView

/**
 显示大图

 @param targetImageView 可点击的目标ImageView
 */
+ (void)showBigImageWithTarget:(UIImageView *)targetImageView;
@end

NS_ASSUME_NONNULL_END
