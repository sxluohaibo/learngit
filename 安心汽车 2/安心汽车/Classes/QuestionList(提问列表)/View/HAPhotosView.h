//
//  HAPhotosView.h
//  提问列表demo1
//
//  Created by un2lock on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HAPhotosView;
@protocol HAPhotosViewDelegate <NSObject>
-(void) photoView:(HAPhotosView *) photoView;
@end


@interface HAPhotosView : UIView
- (void)addPhoto:(UIImage *)photo;
/**里面图片的数量*/
@property(nonatomic,assign) NSUInteger count;
@property (nonatomic, strong, readonly) NSMutableArray *photos;
@property(nonatomic,strong) id<HAPhotosViewDelegate> delegate;
@end


