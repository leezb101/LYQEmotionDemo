//
//  LYQComposePhotosView.h
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/5.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYQComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;

@property (nonatomic,strong, readonly) NSMutableArray *photos;
@end
