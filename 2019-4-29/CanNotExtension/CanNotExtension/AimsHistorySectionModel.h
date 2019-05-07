//
//  AimsHistorySectionModel.h
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/11.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AimsHistorySectionModel : NSObject
@property(nonatomic,strong)NSArray *applicationform;
@property(nonatomic,strong)NSArray *applicationinfoform;
@property(nonatomic,strong)NSArray *applicationothers;
@property(nonatomic,strong)NSArray *coborrowrelation;
@property(nonatomic,strong)NSArray *coidproofA;
@property(nonatomic,strong)NSArray *coidproofB;
@property(nonatomic,strong)NSArray *coliving;
@property(nonatomic,strong)NSArray *colivingdetection;
@property(nonatomic,strong)NSArray *cocontract;
@property(nonatomic,strong)NSArray *cosigning;
@property(nonatomic,strong)NSArray *contract;

@property(nonatomic,strong)NSString *syncDate;
@property(nonatomic,strong)NSString *uploadId;

@property(nonatomic,strong)NSArray *driverlicense;
@property(nonatomic,strong)NSArray *fundinginfoform;
@property(nonatomic,strong)NSArray *fundingothers;
@property(nonatomic,strong)NSArray *idproofA;
@property(nonatomic,strong)NSArray *idproofB;
@property(nonatomic,strong)NSArray *incomeproof;
@property(nonatomic,strong)NSArray *living;
@property(nonatomic,strong)NSArray *livingdetection;
@property(nonatomic,strong)NSArray *signing;

@property(nonatomic,strong)NSString *syncStatus;

@property(nonatomic,strong)NSArray *usedcar;
@end

NS_ASSUME_NONNULL_END
