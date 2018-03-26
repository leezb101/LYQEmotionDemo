//
//  LYQComposeViewController.m
//  LYQEmotionDemo
//
//  Created by leezb101 on 16/9/8.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LYQComposePhotosView.h"
#import "LYQComposeToolbar.h"
#import "LYQComposeViewController.h"
#import "LYQCustomTextView.h"
#import "LYQEmotion.h"
#import "LYQEmotionKeyboard.h"
#import "LYQEmotionTextView.h"
#import "UIView+Extension.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface LYQComposeViewController () <UITextViewDelegate, LYQComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 输入控件 */
@property (nonatomic, weak) LYQEmotionTextView* textView;
/** 键盘顶部工具条 */
@property (nonatomic, weak) LYQComposeToolbar* toolbar;
/** 相册，存放拍照或者相册中选择的图片 */
@property (nonatomic, weak) LYQComposePhotosView* photoView;
/** 表情键盘*/
@property (nonatomic, strong) LYQEmotionKeyboard* emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeyboard;

@end

@implementation LYQComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNav];
    [self setupInput];
    [self setupToolbar];
    [self setupPhotoView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.textView becomeFirstResponder];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(nilSymbol)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(nilSymbol)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    self.title = @"发帖";
}
/** 设置输入框顶部工具栏 */
- (void)setupToolbar
{
    LYQComposeToolbar* toolbar = [[LYQComposeToolbar alloc] init];
    [self.view addSubview:toolbar];
    [toolbar mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.height.equalTo(44);
        make.width.equalTo(self.view.mas_width);
    }];
    self.toolbar = toolbar;
}
/** 设置输入框 */
- (void)setupInput
{

    LYQEmotionTextView* textView = [[LYQEmotionTextView alloc] init];
    textView.placeholder = @"分享新鲜事";
    //垂直方向上可以拖拽
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.left.bottom.right.equalTo(0);
    }];
    textView.delegate = self;
    self.textView = textView;

    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameEcho:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //表情选中通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelectEcho:) name:@"EmotionDidSelectNotification" object:nil];
    //键盘删除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnEcho) name:@"EmotionDidDeleteNotification" object:nil];
}

- (void)setupPhotoView
{

    LYQComposePhotosView* photoView = [[LYQComposePhotosView alloc] init];
    [self.textView addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(400);
        make.top.equalTo(130);
        make.left.equalTo(0);
    }];
}

#pragma mark - 各种view的通知响应事件
/** 表情被选中了收到通知响应 */
- (void)emotionDidSelectEcho:(NSNotification*)notification
{
    LYQEmotion* emotion = notification.userInfo[@"SelectEmotionKey"];

    [self.textView insertEmotion:emotion];
}

/** 键盘删除按钮点击收到通知响应 */
- (void)deleteBtnEcho
{
    [self.textView deleteBackward];
}

/** 键盘frame改变时调用 */
- (void)keyboardWillChangeFrameEcho:(NSNotification*)notification
{

    //如果正在切换键盘的过程中，就不执行后续代码
    if (self.switchingKeyboard) {
        return;
    }

    NSDictionary* userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        //工具条改变纵向位置
        if (keyboardFrame.origin.y > self.view.height) {
            [self.toolbar mas_updateConstraints:^(MASConstraintMaker* make) {
                make.bottom.equalTo(0);
            }];
        }
        else {
            [self.toolbar mas_updateConstraints:^(MASConstraintMaker* make) {
                make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardFrame.origin.y);
            }];
        }
        [self.toolbar setNeedsLayout];
        [self.toolbar layoutIfNeeded];
    }];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    [self.view endEditing:YES];
}

- (void)composeToolbar:(LYQComposeToolbar*)toolbar didClickButton:(LYQComposeToolbarType)buttonType
{

    switch (buttonType) {
    case LYQComposeToolbarTypeCamera: {
        //拍照
        [self openCamera];
        break;
    }
    case LYQComposeToolbarTypePicture: {
        //相册
        [self openAlbum];
        break;
    }
    case LYQComposeToolbarTypeMetion: {
        //@

        break;
    }
    case LYQComposeToolbarTypeTrend: {
        //＃

        break;
    }
    case LYQComposeToolbarTypeEmotion: {
        //表情／键盘
        [self switchKeyboard];
        break;
    }
    }
}

#pragma mark - 键盘切换等方法
- (void)switchKeyboard
{
    if (self.textView.inputView == nil) {
        //显示成表情键盘
        self.textView.inputView = self.emotionKeyboard;
        //同时切换成键盘按钮
        self.toolbar.showKeyboardButton = YES;
    }
    else {
        self.textView.inputView = nil;
        //显示表情按钮
        self.toolbar.showKeyboardButton = NO;
    }
    //开始切换键盘
    self.switchingKeyboard = YES;
    //退出键盘
    [self.textView endEditing:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        [self.textView becomeFirstResponder];
        self.switchingKeyboard = NO;
    });
}

- (void)openCamera
{
}

- (void)openAlbum
{
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
}

- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 发送带图微博 */
- (void)sendWithImage
{
}

/** 发布没图微博 */
- (void)sendWithoutImage
{
}

/** 发送 */
- (void)send
{
}

#pragma mark - 懒加载 键盘
- (LYQEmotionKeyboard*)emotionKeyboard
{
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[LYQEmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 256;
    }
    return _emotionKeyboard;
}

@end
