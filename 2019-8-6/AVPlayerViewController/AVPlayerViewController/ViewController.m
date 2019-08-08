//
//  ViewController.m
//  AVPlayerViewController
//
//  Created by 吉腾蛟 on 2019/8/7.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePicker_VC;

@property(nonatomic,strong)AVPlayerViewController *player;

@property(nonatomic,strong)NSURL *mediaUrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化UI
-(UIImagePickerController *)imagePicker_VC{
    if (!_imagePicker_VC) {
        _imagePicker_VC=[[UIImagePickerController alloc] init];
        
        //采集源类型
        _imagePicker_VC.sourceType=UIImagePickerControllerSourceTypeCamera;
        
        //媒体类型
        _imagePicker_VC.mediaTypes=[NSArray arrayWithObject:(__bridge NSString *)kUTTypeMovie];
        
        //设置代理
        _imagePicker_VC.delegate=self;
        
        //视频质量
        _imagePicker_VC.videoQuality=UIImagePickerControllerQualityTypeHigh;
    }
    return _imagePicker_VC;
}
-(AVPlayerViewController *)player{
    if (!_player) {
        _player=[[AVPlayerViewController alloc] init];
        
        //创建avPlayer对象
        _player.player=[[AVPlayer alloc] initWithURL:self.mediaUrl];
        
        //播放窗口
//        //1.全屏幕
//        [self presentViewController:self.player animated:YES completion:nil];

        //2.小屏窗口
        self.player.view.frame=CGRectMake(10, 100, 400, 400);
        [self.view addSubview:self.player.view];
    }
    return _player;
}
- (IBAction)playVideo:(id)sender {
    //播放视频
    [self.player.player play];
}
#pragma mark - 懒加载

#pragma mark - 代理
//采集媒体数据完成的回调处理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //获取媒体类型
    NSString *type=info[UIImagePickerControllerMediaType];
    //如果是视频类型
    if ([type isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        //获取视频媒体的URL
        self.mediaUrl=info[UIImagePickerControllerMediaURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//采集媒体数据取消的回调处理
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您已经取消了采集视频");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - target action
- (IBAction)pickVideo:(id)sender {
    //如果摄像头可用，从摄像头采集视频数据
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self presentViewController:self.imagePicker_VC animated:YES completion:nil];
    }
}
#pragma mark - Maonry

#pragma mark - other 只有本页面会使用的工具方法


@end
