//
//  ViewController.m
//  ForNancy
//
//  Created by admin on 2019/4/27.
//  Copyright © 2019 Sony. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *content;

@property(nonatomic,strong)UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label=[[UILabel alloc] initWithFrame:CGRectMake(0, 200, 100, 20)];
    
    self.label.text=@"label";
    self.label.font=[UIFont systemFontOfSize:20.0];
    self.label.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:self.label];
}


@end
