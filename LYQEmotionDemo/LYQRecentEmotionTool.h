//
//  LYQRecentEmotionTool.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYQEmotion;
@interface LYQRecentEmotionTool : NSObject
+ (void)addRecentEmotion:(LYQEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
