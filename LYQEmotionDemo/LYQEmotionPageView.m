//
//  LYQEmotionPageView.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionPageView.h"
#import "LYQEmotion.h"
#import "LYQEmotionButton.h"
#import "LYQRecentEmotionTool.h"

@interface LYQEmotionPageView()
/** 删除按钮 */
@property (nonatomic,strong) UIButton *deleteBtn;

@end

@implementation LYQEmotionPageView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self deleteBtn];
    }
    return self;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [_deleteBtn addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

- (void)deleteClicked:sender {

    //发送删除通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidDeleteNotification" object:nil];

}

- (void)setEmotions:(NSArray<LYQEmotion *> *)emotions {
    _emotions = emotions;

    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        LYQEmotionButton *btn = [[LYQEmotionButton alloc] init];
        [self addSubview:btn];
        //设置表情数据
        btn.emotion = emotions[i];

        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}
/** 表情按钮点击事件 */
- (void)btnClicked:(LYQEmotionButton *)btn {
    [self selectEmotion:btn.emotion];
}

- (void)selectEmotion:(LYQEmotion *)emotion {

    //将这个表情存进沙盒
    [LYQRecentEmotionTool addRecentEmotion:emotion];

    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"SelectEmotionKey"] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidSelectNotification" object:nil userInfo:userInfo];

}



@end
