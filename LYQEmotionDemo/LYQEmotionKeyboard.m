//
//  LYQEmotionKeyboard.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionKeyboard.h"
#import "LYQEmotionTabBar.h"
#import "LYQEmotionListView.h"
#import "LYQEmotion.h"
#import "MJExtension.h"
#import "LYQRecentEmotionTool.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface LYQEmotionKeyboard () <LYQEmotionTabBarDelegate>

/** 保存正在显示的listView */
@property (nonatomic,weak) LYQEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic,strong) LYQEmotionListView *recentListView;
@property (nonatomic,strong) LYQEmotionListView *defaultListView;
@property (nonatomic,strong) LYQEmotionListView *emojiListView;
@property (nonatomic,strong) LYQEmotionListView *lxhListView;

/** tabbar */
@property (nonatomic,weak) LYQEmotionTabBar *tabBar;
@end

@implementation LYQEmotionKeyboard

- (LYQEmotionListView *)recentListView {
    if (!_recentListView) {
        _recentListView = [[LYQEmotionListView alloc] init];
        //加载沙盒中的数据
        _recentListView.emotions = [LYQRecentEmotionTool recentEmotions];

    }
    return _recentListView;
}

- (LYQEmotionListView *)defaultListView {
    if (!_defaultListView) {
        _defaultListView = [[LYQEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info" ofType:@"plist"];
        self.defaultListView.emotions = [LYQEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];

    }
    return _defaultListView;
}

- (LYQEmotionListView *)emojiListView {
    if (!_emojiListView) {
        _emojiListView = [[LYQEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info" ofType:@"plist"];
        self.emojiListView.emotions = [LYQEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (LYQEmotionListView *)lxhListView {
    if (!_lxhListView) {
        _lxhListView = [[LYQEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info" ofType:@"plist"];
        self.lxhListView.emotions = [LYQEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //Tabbar
        LYQEmotionTabBar *tabbar = [[LYQEmotionTabBar alloc] init];
        tabbar.delegate = self;
        self.tabBar = tabbar;
        //表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:@"EmotionDidSelectNotification" object:nil];
    }
    return self;
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)emotionDidSelect {
    self.recentListView.emotions = [LYQRecentEmotionTool recentEmotions];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //1.tabbar
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.left.equalTo(0);
        make.height.equalTo(37);
        make.bottom.equalTo(0);
    }];
    //2.表情内容（在tabbar的上方）
    [self.showingListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.width.equalTo(0);
        make.bottom.equalTo(self.tabBar.mas_top).offset(0);
    }];

}

#pragma mark - LYQEmotionTabBarDelegate
- (void)emotionTabBar:(LYQEmotionTabBar *)tabBar didSelectButton:(LYQEmotionTabBarButtonType)buttonType {
    //移除正在显示的ListView控件
    [self.showingListView removeFromSuperview];
    //根据按钮类型，切换contentView上的ListView
    
    switch (buttonType) {
        case LYQEmotionTabBarButtonTypeRecent: {
            [self addSubview:self.recentListView];
            break;
        }
        case LYQEmotionTabBarButtonTypeDefault: {
            [self addSubview:self.defaultListView];
            break;
        }
        case LYQEmotionTabBarButtonTypeEmoji: {
            [self addSubview:self.emojiListView];
            break;
        }
        case LYQEmotionTabBarButtonTypeLxh: {
            [self addSubview:self.lxhListView];
            break;
        }
    }

    //设置正在显示的ListView
    self.showingListView = [self.subviews lastObject];
    //重新计算子控件的frame（setNeedsLayout内部会在恰当的时刻重新调用layoutSubViews，重新布局子控件）
    [self setNeedsLayout];
}

@end
