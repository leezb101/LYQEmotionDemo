//
//  LYQEmotionListView.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/6.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQEmotionListView.h"
#import "LYQEmotionPageView.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

/** 每一页的表情数量 */
#define LYQEmotionPageSize 20

@interface LYQEmotionListView () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation LYQEmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self scrollView];
        [self pageControl];
    }
    return self;
}

- (void)setEmotions:(NSArray<LYQEmotion *> *)emotions {
    _emotions = emotions;

    //删除之前的表情控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //计算页码
    NSUInteger count = (emotions.count + LYQEmotionPageSize - 1) / LYQEmotionPageSize;
      //1.设置页数
    self.pageControl.numberOfPages = count;
      //2.创建用来显示每一页表情的空控件
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        LYQEmotionPageView *pageView = [[LYQEmotionPageView alloc] init];
        //计算这一页的表情范围
        NSRange range;
        range.location = i * LYQEmotionPageSize;
        //left:剩余表情的个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= LYQEmotionPageSize) {
            range.length = LYQEmotionPageSize;
        } else {
            range.length = left;
        }

        //设置这一页表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }

    [self setNeedsLayout];

}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0);
        make.height.equalTo(35);
        make.left.bottom.equalTo(0);
    }];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0);
        make.top.left.equalTo(0);
        make.bottom.equalTo(self.pageControl.mas_top).offset(0);
    }];
    [self.scrollView setNeedsLayout];
    [self.scrollView layoutIfNeeded];

    //设置scrollView内部每一页PageView的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i  < count; i++) {
        LYQEmotionPageView *pageView = self.scrollView.subviews[i];
        LYQEmotionPageView *lastPageView;
        [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }];
        if (0 == i) {
            [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
            }];
            [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(pageView.mas_bottom);
            }];
        }else {
            [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastPageView.mas_right);
            }];
        }
        if (count - 1 == i) {
            [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(0);
            }];
            [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(pageView.mas_right);
            }];
        }
        lastPageView = pageView;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNum = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = (int)(pageNum + 0.5);
}

#pragma mark - 懒加载 - scrollView和pageControl
/** 表情页滚动视图 */
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
/** 表情页滚动视图的标记 */
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}
@end
