//
//  FileUploadOutsiderHeaderView.h
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUploadOutsiderHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *date_label;
@property(nonatomic,strong)UILabel *aimsStatus_Label;
@property(nonatomic,strong)UIButton *retry_button;
@property(nonatomic,strong)NSString *uploadId;
@end

NS_ASSUME_NONNULL_END
