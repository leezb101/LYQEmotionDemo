//
//  LYQEmotion.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQEmotion : NSObject
/** 表情中文字符串 */
@property (nonatomic,copy) NSString *chs;
/** 表情png图片名 */
@property (nonatomic,copy) NSString *png;
/** emoji表情16进制编码 */
@property (nonatomic,copy) NSString *code_16B;

@end
