//
//  NSObject+NullStringFilter.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/25.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "NSObject+NullStringFilter.h"

@implementation NSObject (NullStringFilter)
-(NSString *)isEmptyOfString:(NSString *)string{
    if([string isEqualToString:@"(null)"]){
        return @"";
    }else if (string.length==0){
        return @"";
    }else{
        return string;
    }
}
@end
