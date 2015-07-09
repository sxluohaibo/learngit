//
//  HAMessageCell.h
//  01-QQ聊天界面
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HAMessageFrameModel;
@class HAMessageCell;

@protocol HAMessageCellDelegate <NSObject>
/** 点击选择图片的按钮*/
-(void)clickSendPicture:(UIImage *)image;

@end

@interface HAMessageCell : UITableViewCell
@property (nonatomic,assign) id<HAMessageCellDelegate> delegate;

+ (instancetype)messageCellWithTableView:(UITableView *)tableview;
//frame 的模型
@property (nonatomic, strong)HAMessageFrameModel *frameMessage;

@end
