//
//  HADetailVoicesView.m
//  安心汽车
//
//  Created by un2lock on 15/5/6.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HADetailVoicesView.h"

#define imageWH 42
@interface HADetailVoicesView()
@property(nonatomic,strong) AVAudioPlayer *player;
/** 是否正在播放*/
@property (nonatomic,assign) BOOL playing;
@end

@implementation HADetailVoicesView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
        
    }
    
    return self;
}
-(void)setVoices:(NSMutableArray *)voices{
    _voices=voices;
    NSUInteger voicesCount = voices.count;
    while (self.subviews.count < voicesCount) {
        UIButton *voiceView = [[UIButton alloc] init];
        [self addSubview:voiceView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *voiceView = self.subviews[i];
        voiceView.tag=i;
        if (i < voicesCount) { // 显示
            [voiceView addTarget:self action:@selector(voiceClick:) forControlEvents:UIControlEventTouchUpInside];
            voiceView.titleLabel.font=[UIFont systemFontOfSize:12.0f];
            [voiceView setTitle:[NSString stringWithFormat:@"语音%d",i] forState:UIControlStateNormal];
            [voiceView setTitle:[NSString stringWithFormat:@"语音%d",i] forState:UIControlStateHighlighted];
            voiceView.backgroundColor=[UIColor grayColor];
            voiceView.hidden = NO;
        } else { // 隐藏
            voiceView.hidden = YES;
        }
    }
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
-(void) voiceClick:(UIButton *) sender{
    NSString *voiceFilePath=[_voices objectAtIndex:sender.tag];
    if(_voices==nil) return;
    if(_player!=nil && _player.isPlaying){ //如果还在播放，停止播放
        [_player stop];
        _player = nil;
    }
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:voiceFilePath]];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        _player=[[AVAudioPlayer alloc]initWithData:data error:nil];
                    _player.volume=16.0f;
        if (_player !=nil){
            [_player play];
        }
    }];
}

@end
