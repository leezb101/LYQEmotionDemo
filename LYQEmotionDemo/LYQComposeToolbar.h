//
//  LYQComposeToolbar.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/1.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYQComposeToolbarType) {
    LYQComposeToolbarTypeCamera,
    LYQComposeToolbarTypePicture,
    LYQComposeToolbarTypeMetion,
    LYQComposeToolbarTypeTrend,
    LYQComposeToolbarTypeEmotion
};

@class LYQComposeToolbar;
@protocol LYQComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(LYQComposeToolbar *)toolbar didClickButton:(LYQComposeToolbarType)buttonType;

@end

@interface LYQComposeToolbar : UIView

@property (nonatomic,weak) id<LYQComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮 */
@property (nonatomic,assign) BOOL showKeyboardButton;
@end
