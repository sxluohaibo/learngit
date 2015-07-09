//
//  HAMessageModel.h
//  01-QQ聊天界面
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    HAMessageModelMe = 0,//自己
    HAMessageModelServers=1//服务端人员
}HAMessageModelType;

typedef enum{
    HAMessageModelText=0,  //文字
    HAMessageModelImage=1,  //图片
    HAMessageModelVoice=2,  //语音
}HAMessageModelContentType;
typedef enum{
    HAMessageImageNet=0,  //网络
    HAMessageImageLocal=1,  //本地
}HAMessageModelImageFromType;
typedef enum{
    HAMessageVoiceNet=0,  //网络
    HAMessageVoiceLocal=1,  //本地
}HAMessageModelVoiceFromType;
@interface HAMessageModel : NSObject

//正文
@property (nonatomic, copy)NSString *text;
/**图片*/
@property(nonatomic,strong) UIImage *image;
//时间
@property (nonatomic, copy)NSString *time;

//内容的所属者
@property (nonatomic, assign)HAMessageModelType type;
/**内容的格式*/
@property (nonatomic, assign)HAMessageModelContentType contentType;
/**内容的格式*/
@property (nonatomic, assign)HAMessageModelImageFromType imageFromType;
/**内容的格式*/
@property (nonatomic, assign)HAMessageModelVoiceFromType voiceFromType;
//是否隐藏时间
@property (nonatomic,assign)BOOL hideTime;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end
