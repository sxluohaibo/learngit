//
//  HADetailPhotosView.m
//  安心汽车
//
//  Created by un2lock on 15/5/6.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HADetailPhotosView.h"
#define imageWH 42

@interface HADetailPhotosView()
/**点击放大前图片最后一次的frame*/
@property (nonatomic, assign) CGRect lastFrame;
@property (nonatomic, strong) UIImageView *clickImageView;
@end

@implementation HADetailPhotosView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)setPhotos:(NSMutableArray *)photos{
    _photos=photos;
    
    NSUInteger photosCount = photos.count;
    while (self.subviews.count < photosCount) {
        UIButton *photoView = [[UIButton alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *photoView = self.subviews[i];
        if (i < photosCount) { // 显示
            
            NSString *imageFilePath=[photos objectAtIndex:i];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageFilePath]];
            [photoView setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            [photoView addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
            photoView.backgroundColor=[UIColor redColor];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
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
    UIImage *photo=sender.currentImage;
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
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    int maxCol=5;
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

@end
