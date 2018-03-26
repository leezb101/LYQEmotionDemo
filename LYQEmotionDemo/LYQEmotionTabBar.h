//
//  LYQEmotionTabBar.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/6.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LYQEmotionTabBarButtonType) {
    LYQEmotionTabBarButtonTypeRecent,
    LYQEmotionTabBarButtonTypeDefault,
    LYQEmotionTabBarButtonTypeEmoji,
    LYQEmotionTabBarButtonTypeLxh
};

@class LYQEmotionTabBar;
@protocol LYQEmotionTabBarDelegate <NSObject>

- (void)emotionTabBar:(LYQEmotionTabBar *)tabBar didSelectButton:(LYQEmotionTabBarButtonType)buttonType;
@end

@interface LYQEmotionTabBar : UIView
@property (nonatomic,weak) id<LYQEmotionTabBarDelegate> delegate;
@end
