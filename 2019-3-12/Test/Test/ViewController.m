//
//  ViewController.m
//  Test
//
//  Created by 吉腾蛟 on 2019/3/13.
//  Copyright © 2019 mj. All rights reserved.
//

#import "ViewController.h"
#import "PreviewImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [PreviewImage showBigImageWithTarget:self.imageView1];
}


@end
