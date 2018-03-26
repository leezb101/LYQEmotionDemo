//
//  LYQEmotionTabBar.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/6.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionTabBar.h"
#import "LYQEmotionTabBarButton.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface LYQEmotionTabBar()
@property (nonatomic,weak) LYQEmotionTabBarButton *selectedBtn;
@end

@implementation LYQEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupBtn:@"最近" buttonType:LYQEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:LYQEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:LYQEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:LYQEmotionTabBarButtonTypeLxh];
    }
    return  self;
}

/**
 *  创建一个按钮
 *
 *  @param title      按钮标题
 *  @param buttonType 按钮类型（枚举类型）
 *
 *  @return 一个按钮
 */
- (LYQEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(LYQEmotionTabBarButtonType)buttonType {
    LYQEmotionTabBarButton *btn = [[LYQEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(nilSymbol) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];

    if (buttonType == LYQEmotionTabBarButtonTypeDefault) {
        [self btnClick:btn];
    }

    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (1 == self.subviews.count) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if (4 == self.subviews.count) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }

    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];

    return  btn;
}

- (void)setDelegate:(id<LYQEmotionTabBarDelegate>)delegate {
    _delegate = delegate;

    //选中默认按钮
    [self btnClick:(LYQEmotionTabBarButton *)[self viewWithTag:LYQEmotionTabBarButtonTypeDefault]];
}

- (void)btnClick:(LYQEmotionTabBarButton *)btn {
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;

    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}
/** 排列表情选择 tabbar 的按钮布局 */
- (void)layoutSubviews {
    [super layoutSubviews];

    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        LYQEmotionTabBarButton *lastBtn;
        LYQEmotionTabBarButton *btn = self.subviews[i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }];
        if (0 == i) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
            }];
        }else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).offset(0);
            }];
        }
        if (count - 1 == i) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(0);
            }];
        }
        lastBtn = btn;
    }
}


@end
