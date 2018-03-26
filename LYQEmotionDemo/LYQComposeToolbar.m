//
//  LYQComposeToolbar.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQComposeToolbar.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface LYQComposeToolbar ()
@property (nonatomic,weak) UIButton *emotionButton;
@end

@implementation LYQComposeToolbar
/** 初始化同时增加5个tabbar按钮 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //初始化按钮
        //相机
        [self setupButton:@"compose_camerabutton_background" highLightedImg:@"compose_camerabutton_background_highlighted" type:LYQComposeToolbarTypeCamera];
        //图片
        [self setupButton:@"compose_toolbar_picture" highLightedImg:@"compose_toolbar_picture_highlighted" type:LYQComposeToolbarTypePicture];
        //@
        [self setupButton:@"compose_mentionbutton_background" highLightedImg:@"compose_mentionbutton_background_highlighted" type:LYQComposeToolbarTypeMetion];
        //话题
        [self setupButton:@"compose_trendbutton_background" highLightedImg:@"compose_trendbutton_background_highlighted" type:LYQComposeToolbarTypeTrend];
        //表情
        self.emotionButton = [self setupButton:@"compose_emotionbutton_background" highLightedImg:@"compose_emotionbutton_background_highlighted" type:LYQComposeToolbarTypeEmotion];
    }
    return self;
}
/** 创建一个button */
- (UIButton *)setupButton:(NSString *)image highLightedImg:(NSString *)highLightedImg type:(LYQComposeToolbarType)type {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightedImg] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = type;
    [self addSubview:button];
    return button;
}

/** 设置显示键盘按钮还是表情按钮 */
- (void)setShowKeyboardButton:(BOOL)showKeyboardButton {
    _showKeyboardButton = showKeyboardButton;

    //默认图片名
    NSString *image = @"compose_emotionbutton_background";
    NSString *highLightedImg = @"compose_emotionbutton_background_highlighted";
    //显示键盘图标
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highLightedImg = @"compose_keyboardbutton_background_highlighted";
    }
    //设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highLightedImg] forState:UIControlStateHighlighted];
}

- (void)buttonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:sender.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSUInteger count = self.subviews.count;
    UIButton *lastBtn;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }];
        if (i == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
            }];
        } else if (i == count - 1) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(0);
            }];
        } else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right);
            }];
        }
        lastBtn = btn;
    }
}
@end
