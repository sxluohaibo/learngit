//
//  HAPhotosView.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAPhotosView.h"

#define imageWH 42
@interface HAPhotosView()
@property(nonatomic,weak) UIButton *clickView;
/**点击放大前图片最后一次的frame*/
@property (nonatomic, assign) CGRect lastFrame;
@property (nonatomic, strong) UIImageView *clickImageView;
@end

@implementation HAPhotosView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
        UIButton *clickView = [[UIButton alloc] initWithFrame:CGRectMake(14, 7, imageWH, imageWH)];
        [clickView setBackgroundImage:[UIImage imageNamed:@"add_pic_icon"] forState:UIControlStateNormal];
        [clickView setBackgroundImage:[UIImage imageNamed:@"add_pic_icon"] forState:UIControlStateHighlighted];
        [clickView addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickView];
        self.clickView=clickView;
    }
    return self;
}
-(void)setDelegate:(id<HAPhotosViewDelegate>)delegate{
    _delegate=delegate;
}
- (void)addPhoto:(UIImage *)photo
{
    UIButton *photoView = [[UIButton alloc] init];
    [photoView addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
    [photoView setBackgroundImage:photo forState:UIControlStateNormal];
    if(_count==1){
        [self insertSubview:photoView atIndex:0];
    }else{
        [self insertSubview:photoView atIndex:_count-1];
    }
    
    [self.photos addObject:photoView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    _count=count;
    
    int maxCol= 6 ;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i<count; i++) {
        UIButton *photoView = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        photoView.x = col * (imageWH + imageMargin) + 14;
        photoView.y = row * (imageWH + imageMargin)+ 5;
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}
-(void) photoClick:(UIButton *) sender{
    // 1.添加一个遮盖
    UIView *cover = [[UIView alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)]];
     [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    // 2.添加图片到遮盖上
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *photo=sender.currentBackgroundImage;
    imageView.image=photo;
    imageView.frame = [cover convertRect:sender.frame fromView:self];
    self.lastFrame = imageView.frame;
    self.clickImageView = imageView;
    [cover addSubview:imageView];
    //    // 3.放大
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = imageView.frame;
        frame.size.width = cover.width; // 占据整个屏幕;
        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
        frame.origin.x = 0;
        frame.origin.y = (cover.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}
/**点击放大后图片，缩小*/
- (void)tapCover:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        recognizer.view.backgroundColor = [UIColor clearColor];
        self.clickImageView.frame = self.lastFrame;
    } completion:^(BOOL finished) {
        [recognizer.view removeFromSuperview];
        self.clickImageView = nil;
    }];
}
-(void) addImage:(UIButton *) sender{
    if([self.delegate respondsToSelector:@selector(photoView:)]){
        [self.delegate photoView:self];
    }
}



@end
