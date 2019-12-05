//
//  StudentTableViewCell.h
//  FunWithCoreData
//
//  Created by 吉腾蛟 on 2019/12/5.
//  Copyright © 2019 JY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN

@interface StudentTableViewCell : UITableViewCell

-(void)setContentWithStudentModel:(Student *)model;

@end

NS_ASSUME_NONNULL_END
