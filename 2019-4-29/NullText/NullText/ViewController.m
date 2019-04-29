//
//  ViewController.m
//  NullText
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 JiYoung. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+NullString.h"

@interface ViewController ()
@property(nonatomic,strong)UILabel *title_label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(300, 100, 200, 40)];
    label.text=@"你好啊";
    [label setText:@"很好的"];
    label.text=@"wow fantasi";
    label.text=@"";
    label.text=@"(null)";
    label.text=@"你的的的(null)";
    label.textColor=[UIColor blueColor];
    
    [self.view addSubview:label];
}


@end
