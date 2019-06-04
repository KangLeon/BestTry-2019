//
//  Header.h
//  XinSystem
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#ifndef Header_h
#define Header_h

/* 1:正式环境；0:测试环境 */
#define IS_SERVER               1

//域名
#define XS_HOST                     IS_SERVER==1 ? @"https://xinapi.csmc-cloud.com" : @"https://forbid.csmc-cloud.com"

//屏幕宽高比
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//全局颜色RGB值
#define OLIVEGREEN [UIColor colorWithRed:22/255.0 green:51/255.0 blue:19/255.0 alpha:1.0]
#define SHADOWNGRAY [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
#define TIMEBLUE [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1.0]

#endif /* Header_h */
