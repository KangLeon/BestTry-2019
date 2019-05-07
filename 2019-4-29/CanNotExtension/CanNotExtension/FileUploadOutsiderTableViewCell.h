//
//  FileUploadOutsiderTableViewCell.h
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AimsHistorySectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FileUploadOutsiderTableViewCell : UITableViewCell
/**
 设置数据
 
 @param model 需要设置的数据
 */
-(void)setCellContentWithAimsHistorySectionModel:(AimsHistorySectionModel *)model;
@end

NS_ASSUME_NONNULL_END
