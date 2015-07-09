//
//  HMMessageFrameModel.h
//  01-QQ聊天界面
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HAMessageModel;
@interface HAMessageFrameModel : NSObject

//时间的frame
@property (nonatomic, assign,readonly)CGRect timeF;

//正文的frame
@property (nonatomic, assign,readonly)CGRect textViewF;
//图片的frame
@property (nonatomic, assign,readonly)CGRect sendImageF;
//图片
@property (nonatomic, assign,readonly)CGRect iconF;

//cell
@property (nonatomic, assign,readonly)CGFloat cellH;

//数据模型
@property (nonatomic, strong)HAMessageModel *message;
@end
