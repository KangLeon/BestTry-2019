//
//  TagTextView.m
//  KOOV
//
//  Created by 吉腾蛟 on 2019/1/29.
//  Copyright © 2019 Sony. All rights reserved.
//

#import "TagTextView.h"

#import "TagLabel.h"

@interface TagTextView ()


@property(nonatomic,strong)UIButton *edit_button;

@property(nonatomic,strong)NSMutableSet *tags_set;
@end

@implementation TagTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}
#pragma mark - 初始化UI
-(void)addUI{
    [self addSubview:self.addTag_button];
    
    [self.addTag_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(SNTrueWidth(40));
        make.height.mas_equalTo(SNTrueHeight(40));
    }];
}
#pragma mark - 懒加载
-(UIButton *)addTag_button{
    if (!_addTag_button) {
        _addTag_button=[[UIButton alloc] init];
        [_addTag_button setImage:[UIImage imageNamed:@"add_tag"] forState:UIControlStateNormal];
        [[_addTag_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self updateConstraintsWithState:TagTextViewStateAdd];
        }];
    }
    return _addTag_button;
}
-(PlaceHoldTextView *)text_view{
    if (!_text_view) {
        _text_view=[[PlaceHoldTextView alloc] init];
        _text_view.font=[UIFont systemFontOfSize:20.0];
        _text_view.backgroundColor=RGBA(236, 248, 249, 1.0);
        _text_view.placeholder_label.text=@"10个汉字以内";
    }
    return _text_view;
}
-(UIButton *)yes_button{
    if (!_yes_button) {
        _yes_button=[[UIButton alloc] init];
        [_yes_button setTitle:@"完成" forState:UIControlStateNormal];
        [_yes_button setTitleColor:TEXT_BLACK forState:UIControlStateNormal];
        [_yes_button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _yes_button.enabled=NO;
        [[_yes_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSString *tag=self.text_view.text;
            if ([tag isEqualToString:@""] | [self.tags_set containsObject:tag]) {
                
            }else{
                [self.tags_set addObject:tag];
            }
            self.text_view.text=@"";
            if (self.tags_set.count==0) {
                [self updateConstraintsWithState:TagTextViewStateNormal];
            }else{
                [self updateConstraintsWithState:TagTextViewStateTags];
            }
        }];
    }
    return _yes_button;
}
-(UIButton *)cancel_button{
    if (!_cancel_button) {
        _cancel_button=[[UIButton alloc] init];
        [_cancel_button setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel_button setTitleColor:TEXT_BLACK forState:UIControlStateNormal];
        [[_cancel_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.tags_set.count==0) {
                [self updateConstraintsWithState:TagTextViewStateNormal];
            }else{
                [self updateConstraintsWithState:TagTextViewStateTags];
            }
        }];
    }
    return _cancel_button;
}
-(UIButton *)edit_button{
    if (!_edit_button) {
        _edit_button=[[UIButton alloc] init];
        [_edit_button setTitle:@"编辑" forState:UIControlStateNormal];
        [_edit_button setTitleColor:TEXT_BLACK forState:UIControlStateNormal];
        [[_edit_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self updateConstraintsWithState:TagTextViewStateEdit];
        }];
    }
    return _edit_button;
}
-(NSMutableSet *)tags_set{
    if (!_tags_set) {
        _tags_set=[[NSMutableSet alloc] init];
    }
    return _tags_set;
}
#pragma mark - 代理

#pragma mark - target action

#pragma mark - Maonry

#pragma mark - other 只有本页面会使用的工具方法
-(void)updateConstraintsWithState:(TagTextViewState)state{
    switch (state) {
        case TagTextViewStateNormal:
        {
            [self.text_view removeFromSuperview];
            [self.yes_button removeFromSuperview];
            [self.cancel_button removeFromSuperview];
            [self addUI];
        }
            break;
        case TagTextViewStateAdd:
        {
            //先添加tags标签
            [self.text_view removeFromSuperview];
            [self.yes_button removeFromSuperview];
            [self.cancel_button removeFromSuperview];
            CGFloat width = 0.0;
            CGFloat y = 0.0;
            @autoreleasepool {
                NSInteger count=0;
                for (NSString *tag_title in self.tags_set) {
                    UILabel *lbl_text = [[UILabel alloc]init];
                    lbl_text.backgroundColor = RGBA(238, 244, 250, 1.0);
                    lbl_text.textColor=TEXT_BROWN;
                    lbl_text.text = tag_title;
                    lbl_text.textAlignment=NSTextAlignmentCenter;
                    // 设置Label的字体 HelveticaNeue  Courier
                    UIFont *fnt = [UIFont fontWithName:@"Courier New" size:13.0];
                    lbl_text.font = fnt;
                    // 根据字体得到NSString的尺寸
                    CGSize size = [lbl_text.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName,nil]];
                    CGFloat nameH = size.height+SNTrueHeight(25);
                    CGFloat nameW = size.width+SNTrueWidth(25);
                    lbl_text.frame = CGRectMake(width+5*count,0, nameW,nameH);
                    width+=(nameW+5*count);
                    //                    [self bezierView:lbl_text withRectCorner:UIRectCornerAllCorners andCornerRadi:CGSizeMake(9.0, 9.0)];
                    [self addSubview:lbl_text];
                    y=lbl_text.frame.origin.y+lbl_text.frame.size.height;
                }
            }
            
            //添加输入框view
            [self.addTag_button removeFromSuperview];
            [self addSubview:self.text_view];
            [self addSubview:self.yes_button];
            self.yes_button.hidden=YES;
            [self addSubview:self.cancel_button];
            self.cancel_button.hidden=YES;
            
            [self.text_view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.top.equalTo(self.mas_top).offset(y+SNTrueHeight(10));
                make.width.mas_equalTo(SNTrueWidth(300));
                make.height.mas_equalTo(SNTrueHeight(40));
            }];
            [self.yes_button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.text_view.mas_left).offset(SNTrueWidth(15));
                make.centerY.equalTo(self.text_view.mas_centerY);
            }];
            [self.cancel_button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.yes_button.mas_left).offset(SNTrueWidth(15));
                make.centerY.equalTo(self.text_view.mas_centerY);
            }];
            
            // tell constraints they need updating
            [self setNeedsUpdateConstraints];//这个是标记将来在某个时间点进行更新
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.yes_button.hidden=NO;
                self.cancel_button.hidden=NO;
                [self.text_view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left);
                    make.top.equalTo(self.mas_top).offset(y+SNTrueHeight(10));
                    make.width.mas_equalTo(SNTrueWidth(300));
                    make.height.mas_equalTo(SNTrueHeight(40));
                }];
                [self.yes_button mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.text_view.mas_right).offset(SNTrueWidth(15));
                    make.centerY.equalTo(self.text_view.mas_centerY);
                }];
                [self.cancel_button mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.yes_button.mas_right).offset(SNTrueWidth(15));
                    make.centerY.equalTo(self.text_view.mas_centerY);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self bindSingal];
            }];
        }
            break;
        case TagTextViewStateEdit:
        {
            [self.addTag_button removeFromSuperview];
            [self.edit_button removeFromSuperview];
            CGFloat width = 0.0;
            CGFloat y = 0.0;
            @autoreleasepool {
                for (UIView *view in self.subviews) {
                    if (view.tag==10000) {
                        UIButton *delete_button=[[UIButton alloc] initWithFrame:CGRectMake(SNTrueWidth(-5), SNTrueHeight(-5), SNTrueWidth(15), SNTrueHeight(15))];
                        [delete_button setImage:[UIImage imageNamed:@"delete_tag"] forState:UIControlStateNormal];
                        [view addSubview:delete_button];
                        y=view.frame.origin.y+view.frame.size.height;
                        width=view.frame.origin.x+view.frame.size.width;
                        [[delete_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                            UIResponder *responder=delete_button;
                            while ((responder=[responder nextResponder])) {
                                if ([responder isKindOfClass:[UIView class]]) {
                                    UIView *view=(UIView *)responder;
                                    for (UILabel *label in view.subviews) {
                                        if ([label isKindOfClass:[UILabel class]]) {
                                            NSString *title_string=label.text;
                                            [self.tags_set removeObject:title_string];
                                        }
                                    }
                                    break;
                                }
                            }
                            
                            [self regroupLabel];
                        }];
                    }
                }
            }
            
            [self addSubview:self.yes_button];

            [self.yes_button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(width+SNTrueWidth(10));
                make.top.equalTo(self.mas_top);
            }];
        }
            break;
        case TagTextViewStateTags:
        {
            [self.text_view removeFromSuperview];
            [self.yes_button removeFromSuperview];
            [self.cancel_button removeFromSuperview];
            
            //重组标签池
            CGSize size=[self regroupLabel];
            
            [self addSubview:self.edit_button];
            [self.edit_button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(size.width+SNTrueWidth(10));
                make.top.equalTo(self.mas_top);
            }];
            
            [self addSubview:self.addTag_button];
            [self.addTag_button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.top.equalTo(self.mas_top).offset(size.height+SNTrueHeight(10));
                make.width.mas_equalTo(SNTrueWidth(40));
                make.height.mas_equalTo(SNTrueHeight(40));
            }];
        }
            break;
        default:
            break;
    }
}
-(CGSize)regroupLabel{
    for (UIView *view in self.subviews) {
        if (view.tag==10000) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat width = 0.0;
    CGFloat y = 0.0;
    @autoreleasepool {
        NSInteger count=0;
        for (NSString *tag_title in self.tags_set) {
            UIView *view=[[UIView alloc] init];
            view.tag=10000;
            UILabel *lbl_text = [[UILabel alloc]init];
            lbl_text.backgroundColor = RGBA(238, 244, 250, 1.0);
            lbl_text.textColor=TEXT_BROWN;
            lbl_text.text = tag_title;
            lbl_text.textAlignment=NSTextAlignmentCenter;
            // 设置Label的字体 HelveticaNeue  Courier
            UIFont *fnt = [UIFont fontWithName:@"Courier New" size:13.0];
            lbl_text.font = fnt;
            // 根据字体得到NSString的尺寸
            CGSize size = [lbl_text.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName,nil]];
            CGFloat nameH = size.height+SNTrueHeight(25);
            CGFloat nameW = size.width+SNTrueWidth(25);
            lbl_text.frame = CGRectMake(width+5*count,0, nameW,nameH);
            width+=(nameW+5*count);
            [self bezierView:lbl_text withRectCorner:UIRectCornerAllCorners andCornerRadi:CGSizeMake(lbl_text.frame.size.height/2, lbl_text.frame.size.height/2)];
            [view addSubview:lbl_text];
            y=lbl_text.frame.origin.y+lbl_text.frame.size.height;
            view.frame=lbl_text.frame;
            view.layer.cornerRadius=lbl_text.frame.size.height/2;
            [self addSubview:view];
        }
    }
    return CGSizeMake(width, y);
}
-(void)bindSingal{
    [[self.text_view rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        if (x.length == 0){
            self.text_view.placeholder_label.hidden = NO;
        }else{
            self.text_view.placeholder_label.hidden = YES;
        }
        
        if (x.length>0) {
            self.yes_button.enabled=YES;
        }else{
            self.yes_button.enabled=NO;
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
