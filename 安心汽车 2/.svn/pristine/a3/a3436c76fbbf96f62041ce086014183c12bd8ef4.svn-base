//
//  HAVoiceView.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/29.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAVoicesView.h"

#define imageWH 42
@interface HAVoicesView()
@property(nonatomic,weak) UIImageView *clickView;
/*存放语音的地址集合*/
@property(nonatomic,strong) NSMutableArray *voicesArray;
@property(nonatomic,strong) AVAudioPlayer *player;
/** 是否正在播放*/
@property (nonatomic,assign) BOOL playing;
@property (nonatomic,copy) NSString *voiceFilePath;
@end
@implementation HAVoicesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _voices = [NSMutableArray array];
        _voicesArray=[NSMutableArray array];
        UIButton *clickView = [[UIButton alloc] initWithFrame:CGRectMake(0, 7, imageWH, imageWH)];
        [clickView setBackgroundImage:[UIImage imageNamed:@"yuyin_icon-1"] forState:UIControlStateNormal];
        [clickView setBackgroundImage:[UIImage imageNamed:@"yuyin_icon-1"] forState:UIControlStateHighlighted];
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        recognizer.minimumPressDuration = 0.2;
        [recognizer addTarget:self action:@selector(addVoiceClick:)];
        [clickView addGestureRecognizer:recognizer];
        [self addSubview:clickView];
        _clickView=clickView;
    }
    return self;
}
-(void)setDelegate:(id<HAVoicesViewDelegate>)delegate{
    _delegate=delegate;
}
- (void)addVoice:(NSString *) voicePath
{
    [_voicesArray addObject:voicePath];  //把语音地址添加到集合中
    UIButton *voiceView = [[UIButton alloc] init];
    voiceView.backgroundColor=[UIColor grayColor];
    NSString *titleText=[NSString stringWithFormat:@"语音%ld",_voicesArray.count];
    [voiceView setTitle:titleText forState:UIControlStateHighlighted];
    [voiceView setTitle:titleText forState:UIControlStateNormal];
    voiceView.font=[UIFont systemFontOfSize:10.0f];
    [voiceView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [voiceView setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    if(_count==1){
        [self insertSubview:voiceView atIndex:0];
        voiceView.tag=0;
    }else{
        [self insertSubview:voiceView atIndex:_count-1];
        voiceView.tag=_count-1;
    }
    [voiceView addTarget:self action:@selector(voiceViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.voices addObject:voiceView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    _count=count;
    
    int maxCol= 6 ;
    CGFloat imageMargin = 10;
//    CGFloat imageWH=39;
    
    for (int i = 0; i<count; i++) {
        UIButton *photoView = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        photoView.x = col * (imageWH + imageMargin) + 14;
        photoView.y = row * (imageWH + imageMargin) + 4;
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}
-(void)voiceViewClick:(UIButton *)sender{
    if(_player!=nil && _player.isPlaying){ //如果还在播放，停止播放
        [_player stop];
        _player = nil;
    }
    
    NSString *voiceFilePath=[_voicesArray objectAtIndex:sender.tag];
    _voiceFilePath=voiceFilePath;
    NSError *playerError;
    NSData *data=[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:voiceFilePath]];
    _player=[[AVAudioPlayer alloc]initWithData:data error:nil];
    _player.volume=20.0f;
    if (_player == nil)
    {
        HALog(@"ERror creating player: %@", [playerError description]);
    }else{
        [_player play];
    }
}
-(void) addVoiceClick:(UILongPressGestureRecognizer *)recognizer{
    if([self.delegate respondsToSelector:@selector(voiceView:recognizer:)]){
        [self.delegate voiceView:self recognizer:recognizer];
    }
}
@end
