//
//  LYQEmotionTextView.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionTextView.h"
#import "LYQEmotion.h"
#import "LYQEmotionAttachment.h"
#import "NSString+Emoji.h"
#import "UITextView+EmotionEx.h"

@implementation LYQEmotionTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (void)insertEmotion:(LYQEmotion *)emotion {
    if (emotion.code_16B) {
        //insertText：将文字插入到光标所在位置
        [self insertText:emotion.code_16B.emoji];
    } else if (emotion.png) {
        //加载图片
        LYQEmotionAttachment *attach = [[LYQEmotionAttachment alloc] init];
        //传递数据
        attach.emotion = emotion;
        //设置图片尺寸
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);

        //根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        //插入属性文字到光标位置
        [self insertAttributeText:imageStr];
    }
}

- (NSString *)fullText {
    NSMutableString *fullText = [NSMutableString string];
    //遍历所有的属性文字（包括图片、emoji、普通文字）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        //如果是图片表情
        LYQEmotionAttachment *attach = attrs[@"NSAttachment"];

        if (attach) {   //有图片
            [fullText appendString:attach.emotion.chs];
        } else {   //emoji、普通文本
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];

    return fullText;
}

@end
