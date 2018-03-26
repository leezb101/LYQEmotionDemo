//
//  LYQEmotionTabBarButton.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/6.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionTabBarButton.h"

@implementation LYQEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];

    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {

}
@end
