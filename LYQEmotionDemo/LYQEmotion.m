//
//  LYQEmotion.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotion.h"
#import "MJExtension.h"

@interface LYQEmotion() <NSCoding>

@end

@implementation LYQEmotion
MJCodingImplementation


- (BOOL)isEqual:(LYQEmotion *)other {
    return [self.chs isEqualToString:other.chs] || [self.code_16B isEqualToString:other.code_16B];
}


@end
