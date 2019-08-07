//
//  ViewController.m
//  AVFoundationAudio
//
//  Created by 吉腾蛟 on 2019/8/7.
//  Copyright © 2019 JY. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()
@property(nonatomic,strong)AVAudioRecorder *recorder;

@property(nonatomic,strong)AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化UI
-(AVAudioRecorder *)recorder{
    if (!_recorder) {
        
        //路径
        NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
        
        //录音设置
        NSMutableDictionary *settingDic=[[NSMutableDictionary alloc] init];
        
        //采样率
        [settingDic setValue:[NSNumber numberWithInt:44100] forKey:AVSampleRateKey];
        
        //录音格式
        [settingDic setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        
        //录音通道
        [settingDic setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        
        //录音质量
        [settingDic setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        
        _recorder=[[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:settingDic error:nil];
        
        [_recorder prepareToRecord];
    }
    return _recorder;
}
-(AVAudioPlayer *)player{
    if (!_player) {
        //音频文件路径
//        NSString *path=[NSHomeDirectory() stringByAppendingString:@"Documents/record"];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"ITZY-ICY" ofType:@"mp3"];
        
        _player=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        
        [_player prepareToPlay];
    }
    return _player;
}
#pragma mark - 懒加载

#pragma mark - 代理

#pragma mark - target action
- (IBAction)record:(UIButton *)sender {
    if (sender.isSelected == NO) {
        //开启录音
        [self.recorder record];
        sender.selected=YES;
    }else{
        //停止录音
        [self.recorder stop];
        sender.selected=NO;
    }
}
- (IBAction)play:(id)sender {
    //播放
    [self.player play];
}
#pragma mark - Maonry

#pragma mark - other 只有本页面会使用的工具方法



@end
