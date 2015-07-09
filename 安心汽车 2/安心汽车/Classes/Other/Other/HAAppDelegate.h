//
//  AppDelegate.h
//  安心汽车
//
//  Created by tusm on 15-3-3.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GexinSdk.h"
#import "MyNavWithoutPanController.h"
#import "MyNavigationViewController.h"
#import "IIViewDeckController.h"
#import "HAMainViewController.h"
#import "HARightMenuViewController.h"
#import "HALeftMenuViewController.h"
#import "MyNavigationViewController.h"

typedef enum {
    SdkStatusStoped,
    SdkStatusStarting,
    SdkStatusStarted
} SdkStatus;

@interface HAAppDelegate : UIResponder <UIApplicationDelegate,GexinSdkDelegate,UIAlertViewDelegate,IIViewDeckControllerDelegate>{
    NSString *_deviceToken;
}

@property (assign) NSInteger loginType;//登录的后需要执行的相应的操作（1:违章、2咨询、3预约保养、4消息列表 5我的爱车（左边列表点击）6我的爱车（中间点击） ）
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GexinSdk *gexinPusher;
//个推的相关信息
@property (retain, nonatomic) NSString *appKey;
@property (retain, nonatomic) NSString *appSecret;
@property (retain, nonatomic) NSString *appID;
@property (retain, nonatomic) NSString *clientId;
@property (assign, nonatomic) SdkStatus sdkStatus;
@property (nonatomic, strong) UIImageView *bkImageview;//渐变的灰色背景
@property (nonatomic, strong) YTKKeyValueStore *store;


//三个界面
@property (retain, nonatomic) MyNavigationViewController *centerViewController;
@property (retain, nonatomic) IIViewDeckController* deckController;
//下载器
@property (retain, nonatomic) MKNetworkEngine *engine;


//个推
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret;
- (void)stopSdk;

- (void)setDeviceToken:(NSString *)aToken;
- (BOOL)setTags:(NSArray *)aTag error:(NSError **)error;
- (NSString *)sendMessage:(NSData *)body error:(NSError **)error;

@end

