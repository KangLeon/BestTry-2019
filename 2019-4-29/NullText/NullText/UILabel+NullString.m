//
//  UILabel+NullString.m
//  NullText
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 JiYoung. All rights reserved.
//

#import "UILabel+NullString.h"
#import <objc/runtime.h>

@implementation UILabel (NullString)
+ (void)load{
    [super load];
    Method fromMethod =class_getInstanceMethod([UILabel class],@selector(setText:));
    Method toMethod =class_getInstanceMethod([UILabel class], @selector(customsetText:));
    
    if (!class_addMethod([self class], @selector(customsetText:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

- (void)customsetText:(NSString *)text{
    //1.验证登录
    
    
    if ((text.length==0) || [text isEqualToString:@"(null)"] || [text containsString:@"(null)"] || (text==nil)) {
        NSLog(@"字符串为空，并且进行了空值处理");
        text=@"";
    }
    
    [self customsetText:text];
}


@end
