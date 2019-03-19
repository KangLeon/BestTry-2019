//
//  PreviewImage.m
//  KOOV
//
//  Created by 吉腾蛟 on 2019/3/13.
//  Copyright © 2019 Sony. All rights reserved.
//

#import "PreviewImage.h"
//#import "PreviewImageView.h"

@interface PreviewImage ()
@property(nonatomic,strong)UIView *mask_view;
//@property(nonatomic,strong)PreviewImageView *previewImageView;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation PreviewImage

+(PreviewImage *)sharePreview{
    static PreviewImage *previewImage=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        previewImage=[[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return previewImage;
}
#pragma mark - 初始化UI
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    [self addSubview:self.mask_view];
//    [self.mask_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(SCREEN_HEIGHT);
//        make.centerX.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
}
#pragma mark - 懒加载
//-(PreviewImageView *)previewImageView{
//    if (!_previewImageView) {
//        _previewImageView=[[PreviewImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _previewImageView.backgroundColor=[UIColor redColor];
//    }
//    return _previewImageView;
//}
-(UIView *)mask_view{
    if (!_mask_view) {
        _mask_view=[[UIView alloc] initWithFrame:self.frame];
        _mask_view.backgroundColor=[UIColor blackColor];
//        _mask_view.alpha=0.5;
    }
    return _mask_view;
}
#pragma mark - 代理

#pragma mark - target action
+(void)showBigImage{
    UIImage *image=[self sharePreview].imageView.image;
    
//    [[self sharePreview] addSubview:[self sharePreview].previewImageView];
//    [self sharePreview].previewImageView.previewImage.image=image;
//    [self sharePreview].previewImageView.scrollView.zoomScale=1.0;//缩放复原
}
#pragma mark - Maonry

#pragma mark - other 只有本页面会使用的工具方法
+ (void)showBigImageWithTarget:(UIImageView *)targetImageView{
    [self sharePreview].imageView=targetImageView;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage)];
    [targetImageView addGestureRecognizer:tap];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
