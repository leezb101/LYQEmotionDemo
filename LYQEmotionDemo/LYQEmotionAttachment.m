//
//  LYQEmotionAttachment.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionAttachment.h"
#import "LYQEmotion.h"

@implementation LYQEmotionAttachment

- (void)setEmotion:(LYQEmotion *)emotion {
    _emotion = emotion;

    self.image = [UIImage imageNamed:emotion.png];
}
@end
