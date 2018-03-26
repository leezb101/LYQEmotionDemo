//
//  UITextView+EmotionEx.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "UITextView+EmotionEx.h"

@implementation UITextView (EmotionEx)
- (void)insertText:(NSString *)text {

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    //拼接之前的文件
    [attributedText appendAttributedString:self.attributedText];
    //拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedText replaceCharactersInRange:self.selectedRange withString:text];
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];

    self.attributedText = attributedText;
    //移动光标到表情之后的位置
    self.selectedRange = NSMakeRange(loc + 1, 0);

}
@end
