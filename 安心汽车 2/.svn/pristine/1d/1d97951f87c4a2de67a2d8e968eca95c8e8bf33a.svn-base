//
//  HMMessageFrameModel.m
//  01-QQ聊天界面
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HAMessageFrameModel.h"
#import "HAMessageModel.h"
@implementation HAMessageFrameModel

- (void)setMessage:(HAMessageModel *)message
{
    _message = message;
    
    CGFloat padding = 10;
    //1. 时间
    if (message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = ScreenWidth;
        CGFloat timeH = 44;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    //2.头像
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    
    if (message.type == HAMessageModelMe) {//自己发的
        
        iconX = ScreenWidth - iconW - padding;
        
    }else if(message.type == HAMessageModelServers){//别人发的
        iconX = padding;
    }
    
    _iconF =  CGRectMake(iconX, iconY, iconW, iconH);
    //3.正文
    
    CGFloat textX;
    CGFloat textY = iconY+ padding;
    
    CGSize textMaxSize = CGSizeMake(150, MAXFLOAT);
    CGSize textRealSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
    CGSize btnSize;
    switch (message.contentType) {
        case HAMessageModelText:{
            btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height+40);
            break;
        }
        case HAMessageModelVoice:{
            btnSize = CGSizeMake(textRealSize.width, 60);
            break;
        }
        case HAMessageModelImage:{
            if(message.imageFromType==HAMessageImageLocal){
                btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height+160);  //如果图片来自网络，加55高度
            }else{
                btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height+70);  //如果图片来自本地，加150
            }
            break;
        }
        default:
            break;
    }
    if (message.type == HAMessageModelMe) {
        textX = ScreenWidth - iconW - padding*2 - btnSize.width;
    }else if(message.type == HAMessageModelServers){
//        textX = padding + iconW;
//        textX=iconW -10;
        if(message.contentType==HAMessageModelImage){
            textX=iconW -5;
        }else{
           textX = padding + iconW;
        }
    }
    
    _textViewF = (CGRect){{textX,textY},btnSize};
    
    
    _textViewF = (CGRect){{textX,textY},btnSize};
    
    //4.cell高度
    
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textViewF);
    
    _cellH = MAX(iconMaxY, textMaxY) +10;
    
    
}

@end
