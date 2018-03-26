//
//  LYQComposePhotosView.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQComposePhotosView.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation LYQComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _photos  = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo {
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;

    [self addSubview:photoView];
    //图片储存
    [self.photos addObject:photo];

}
//设置图片的尺寸和位置
- (void)layoutSubviews {
    [super layoutSubviews];

    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 80;
    CGFloat imageMargin = 10;

    for (int i = 0; i < count; i++) {
        UIImageView *img = self.subviews[i];
        UIImageView *lastImg;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(imageWH, imageWH));
        }];

        //第一张
        if (i == 0) {
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageMargin);
                make.left.equalTo(imageMargin);
            }];
        } else { //不是第一张

            //每行第一张
            if (i % maxCol == 0) {
                [img mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageMargin);
                }];
            }
            //每行最后一张
            else if (i % maxCol == maxCol - 1) {
                [img mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(imageMargin);
                }];
            } else {
                //每行中间
                [img mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastImg.mas_right).offset(imageMargin);
                }];
            }
        }
        lastImg = img;
    }
}

@end
