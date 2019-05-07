//
//  ViewController.m
//  CanNotExtension
//
//  Created by 吉腾蛟 on 2019/4/30.
//  Copyright © 2019 JiYoung. All rights reserved.
//

#import "ViewController.h"
#import "FileUploadViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FileUploadViewController *file_VC=[[FileUploadViewController alloc] init];
    [self presentViewController:file_VC animated:YES completion:nil];
}


@end
