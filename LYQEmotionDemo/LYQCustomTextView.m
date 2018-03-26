//
//  LYQCustomTextView.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQCustomTextView.h"

@implementation LYQCustomTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //当 UITextView 文字改变时， UITextView 会发出一个 UITextViewTextDidChangeNotification 通知, 此处注册观察接收
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}
/** 注册了通知就要在 dealloc 时清除掉 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 监听文字改变 */
- (void)textDidChange {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.hasText) {
        return;
    }

    //文字属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.font;
    attr[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];

    //draw出文字
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);

    [self.placeholder drawInRect:placeholderRect withAttributes:attr];

}

- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

@end
