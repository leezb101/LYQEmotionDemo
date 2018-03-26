//
//  LYQEmotionTextView.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQCustomTextView.h"

@class LYQEmotion;

@interface LYQEmotionTextView : LYQCustomTextView
- (void)insertEmotion:(LYQEmotion *)emotion;
- (NSString *)fullText;

@end
