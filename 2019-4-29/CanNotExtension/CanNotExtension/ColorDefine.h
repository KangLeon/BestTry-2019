//
//  ColorDefine.h
//  IDFord
//
//  Created by 吉腾蛟 on 2019/3/21.
//  Copyright © 2019 YWJ. All rights reserved.
//

#ifndef ColorDefine_h
#define ColorDefine_h

#define IS_IOS10_OR_ABOVE SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")

#define DISSMISS [SVProgressHUD dismissWithDelay:3.5f];

#define IS_FORD_OR_LINCOLN [[[NSUserDefaults standardUserDefaults] objectForKey:@"systemName"] isEqualToString:@"lincoln"]

//下面的颜色前面是林肯的，后面是福特的
#define TEXT_BLACK_BLUE IS_FORD_OR_LINCOLN ? [UIColor blackColor] : [UIColor colorWithRed:61.0/255.0 green:104.0/255.0 blue:152.0/255.0 alpha:1.0]
#define TEXT_BLACK_WHITE IS_FORD_OR_LINCOLN ? [UIColor blackColor] : [UIColor whiteColor]

#endif /* ColorDefine_h */
