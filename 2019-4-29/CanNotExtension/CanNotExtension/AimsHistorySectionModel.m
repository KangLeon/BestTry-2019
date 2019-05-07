//
//  AimsHistorySectionModel.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/11.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "AimsHistorySectionModel.h"

@implementation AimsHistorySectionModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"applicationform" : @"AimsHistoryCellModel",
             @"applicationinfoform" : @"AimsHistoryCellModel",
             @"applicationothers" : @"AimsHistoryCellModel",
             @"coborrowrelation" : @"AimsHistoryCellModel",
             @"contract" : @"AimsHistoryCellModel",
             @"driverlicense" : @"AimsHistoryCellModel",
             @"fundinginfoform" : @"AimsHistoryCellModel",
             @"fundingothers" : @"AimsHistoryCellModel",
             @"idproofA" : @"AimsHistoryCellModel",
             @"idproofB" : @"AimsHistoryCellModel",
             @"incomeproof" : @"AimsHistoryCellModel",
             @"living" : @"AimsHistoryCellModel",
             @"livingdetection" : @"AimsHistoryCellModel",
             @"signing" : @"AimsHistoryCellModel",
             @"usedcar" : @"AimsHistoryCellModel"
             };
}
@end
