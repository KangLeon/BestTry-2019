//
//  IDFConstant.h
//  IDFord
//
//  Created by fan on 2018/3/12.
//  Copyright © 2018年 YWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDFConstant : NSObject

extern NSString *const IDFMsg;

extern const int IDF_HEIGHT;
extern const int IDF_PHOTO_HEIGHT;
extern const int IDF_ALBUM_PHOTO_HEIGHT;

//user 身份
extern NSString *const IDF_USER_AT;
extern NSString *const IDF_USER_CW;

extern NSString *const IDF_USER_AT_CN;
extern NSString *const IDF_USER_CW_CN;

//拍照各种固定提示
extern NSString *const IDF_PHOTO_POST;

//检测提示语
extern NSString *const IDF_TIP_DTEST_MORE;
extern NSString *const IDF_TIP_DTEST_LITTLE;
extern NSString *const IDF_TIP_SIGN_PHOTO;


//Button文字内容
extern NSString *const IDF_FINISH;
extern NSString *const IDF_NEXT;
extern NSString *const IDF_EDITING;

//loading tips
extern NSString *const IDF_CHECKING_TIP;

//photo type
extern NSString *const IDF_PHOTO_SIGN;
extern NSString *const IDF_PHOTO_CONTR;

//home string
extern NSString *const IDF_HOME_AA;
extern NSString *const IDF_HOME_AP;
extern NSString *const IDF_HOME_FA;
extern NSString *const IDF_HOME_FP;

//app version
extern NSString *const IDF_VERSION;



@end
