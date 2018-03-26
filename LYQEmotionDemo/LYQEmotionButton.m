//
//  LYQEmotionButton.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionButton.h"
#import "LYQEmotion.h"
#import "NSString+Emoji.h"

@implementation LYQEmotionButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setup {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    //按钮高亮时，不要调整图片（不要调整图片会灰色）
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(LYQEmotion *)emotion {
    _emotion = emotion;

    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code_16B) {
        [self setTitle:emotion.code_16B.emoji forState:UIControlStateNormal];
    }
}

@end
