//
//  LYQRecentEmotionTool.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#define LYQRecentEmotionsPath     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archive"]

#import "LYQRecentEmotionTool.h"
#import "LYQEmotion.h"

@implementation LYQRecentEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    if (self == [LYQRecentEmotionTool class]) {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:LYQRecentEmotionsPath];
        if (_recentEmotions == nil) {
            _recentEmotions = [NSMutableArray array];
        }
    }
}

+ (void)addRecentEmotion:(LYQEmotion *)emotion {
    //删除重复表情
    [_recentEmotions removeObject:emotion];
    //将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    //将所有表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:LYQRecentEmotionsPath];
}

+ (NSArray *)recentEmotions {
    return _recentEmotions;
}
@end
