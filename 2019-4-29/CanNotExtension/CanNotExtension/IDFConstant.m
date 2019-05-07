//
//  IDFConstant.m
//  IDFord
//
//  Created by fan on 2018/3/12.
//  Copyright © 2018年 YWJ. All rights reserved.
//

#import "IDFConstant.h"

@implementation IDFConstant

NSString *const IDFMsg = @"通知";

const int IDF_HEIGHT = 20;

const int IDF_PHOTO_HEIGHT = 720;

const int IDF_ALBUM_PHOTO_HEIGHT = 1024;


//user 身份
NSString *const IDF_USER_AT = @"Applicant";
NSString *const IDF_USER_CW = @"Coborrow";

NSString *const IDF_USER_AT_CN = @"申请人";
NSString *const IDF_USER_CW_CN = @"共借人";

//拍照各种固定提示
NSString *const IDF_PHOTO_POST = @"请手持合同签字页拍照";

//检测提示语
NSString *const IDF_TIP_DTEST_MORE = @"1.请按提示操作，在120分钟之内完成动\n   态检测和签约照拍摄";
//@"请在60分钟内完成动态检测";
NSString *const IDF_TIP_DTEST_LITTLE = @"1.请按提示操作，在120分钟之内完成动\n   态检测和签约照拍摄";
//@"请在30分钟内完成动态检测";

NSString *const IDF_TIP_SIGN_PHOTO = @"2.确保与申请阶段采集的照片保持一致\n3.不要佩戴眼镜、口罩、帽子等饰品遮挡\n   人脸";


//Button文字内容
NSString *const IDF_FINISH = @"完成";
NSString *const IDF_NEXT = @"下一步";
NSString *const IDF_EDITING = @"编辑信息";

//loading tips
NSString *const IDF_CHECKING_TIP = @"正在比对";

//photo type
NSString *const IDF_PHOTO_SIGN = @"签字照";
NSString *const IDF_PHOTO_CONTR = @"手持合同照";

//home string
NSString *const IDF_HOME_AA = @"新建申请资料";
NSString *const IDF_HOME_AP = @"补充申请资料";
NSString *const IDF_HOME_FA = @"新建放款资料";
NSString *const IDF_HOME_FP = @"补充放款资料";

//=================================== app version =====================
//  !!!:以后的版本都没有IDV
// native UAT
//NSString *const IDF_VERSION = @"IDV 1.0.7";

// native QAS
NSString *const IDF_VERSION = @"1.1.30";
//NSString *const IDF_VERSION = @"1234";

// native KUT  
//NSString *const IDF_VERSION = @"IDV 1.0.2";

// Ford PRD
//NSString *const IDF_VERSION = @"1.2.1";

// Ford QA
//NSString *const IDF_VERSION = @"1.1.12";

//==================================== BundleId ======================
//福特的
//com.ford.fafcidv

//我们证书的
//com.dragonSoftBravoCompany.IDFord

//=================================== app名称 =========================
//给福特的名称
//掌上便利贷

//我们测试的名称
//FAFC IDV
@end
