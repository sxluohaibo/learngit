//
//  HAVoiceView.h
//  提问列表demo1
//
//  Created by un2lock on 15/4/29.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HAVoicesView;
@protocol HAVoicesViewDelegate <NSObject>
-(void) voiceView:(HAVoicesView *) voiceView recognizer:(UILongPressGestureRecognizer *) recognizer;
@end
@interface HAVoicesView : UIView
- (void)addVoice:(NSString *) voicePath;
/**里面图片的数量*/
@property(nonatomic,assign) NSUInteger count;
@property (nonatomic, strong, readonly) NSMutableArray *voices;
@property(nonatomic,strong) id<HAVoicesViewDelegate> delegate;
@end
