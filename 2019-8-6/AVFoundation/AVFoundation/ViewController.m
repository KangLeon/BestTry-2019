//
//  ViewController.m
//  AVFoundation
//
//  Created by 吉腾蛟 on 2019/8/6.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)UIImagePickerController *imagePickerCon;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIImagePickerController *)imagePickerCon{
    if (!_imagePickerCon) {
        _imagePickerCon=[[UIImagePickerController alloc] init];
        
        //采集源类型
        _imagePickerCon.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        //媒体类型
        _imagePickerCon.mediaTypes=[NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
        
        //设置代理
        _imagePickerCon.delegate=self;
    }
    return _imagePickerCon;
}

- (IBAction)selectImage:(id)sender {
    //通过摄像头来采集
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerCon.sourceType=UIImagePickerControllerSourceTypeCamera;
    }else{
        //通过图片库来采集
        self.imagePickerCon.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerCon animated:YES completion:nil];
}
//完成采集图片后的回调处理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //获取媒体类型
    NSString *type=info[UIImagePickerControllerMediaType];
    //如果媒体类型是图片类型
    if ([type isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        //获取采集到的图片
        UIImage *image=info[UIImagePickerControllerOriginalImage];
        //显示到UI界面
        self.imageView.image=image;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消采集图片的处理
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
