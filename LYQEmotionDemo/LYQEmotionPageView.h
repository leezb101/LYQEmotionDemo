//
//  LYQEmotionPageView.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 一页最多3行 */
#define LYQEmotionMaxRows   3
/** 一页最多7列 */
#define LYQEmotionMaxCols   7
/** 每一页的表情数量 */
#define LYQEmotionPageSize  ((LYQEmotionMaxRows * LYQEmotionMaxCols) - 1)

@class LYQEmotion;
@interface LYQEmotionPageView : UIView

/** 本页显示的表情数组 */
@property (nonatomic,strong) NSArray<LYQEmotion *> *emotions;
@end
