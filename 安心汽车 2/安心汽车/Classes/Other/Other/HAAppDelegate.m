//
//  AppDelegate.m
//  安心汽车
//
//  Created by tusm on 15-3-3.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAppDelegate.h"
#import "CCQGlobalUICommon.h"
#import "MobClick.h"
@interface HAAppDelegate ()

@end

@implementation HAAppDelegate

@synthesize gexinPusher = _gexinPusher;
@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize appID = _appID;
@synthesize clientId = _clientId;
@synthesize sdkStatus = _sdkStatus;
@synthesize engine;
@synthesize centerViewController;
@synthesize bkImageview;
@synthesize store;
@synthesize deckController;
@synthesize loginType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    engine = [[MKNetworkEngine alloc] initWithHostName:MAIN_URL customHeaderFields:nil];
    store = [[YTKKeyValueStore alloc] initDBWithName:@"AnXinQiChe_new.db"];
    [store createTableWithName:VioResultDB];//建表
    
    /**shareSDK*/
    [ShareSDK registerApp:@"4a88b2fb067c"];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    
    //微信应用
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
    //邮件
    [ShareSDK connectSMS];
    
    /**友盟**/
    [MobClick startWithAppkey:UMENGID reportPolicy:BATCH channelId:nil];
    [MobClick setCrashReportEnabled:YES];
    /**友盟注册**/
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HAMainViewController  *centerView = [[HAMainViewController alloc] init];
    //centerView.title = @"中心视图";
    HANavigationController  *centerNav = [[HANavigationController alloc] initWithRootViewController:centerView];
    //--------------------控制只显示左右的侧边栏--------------------
    //HALeftMenuViewController *leftPageController = [[HALeftMenuViewController alloc] init];
    HARightMenuViewController *rightPageController = [[HARightMenuViewController alloc] init];
     
    self.deckController =[[IIViewDeckController alloc]initWithCenterViewController:centerNav leftViewController:nil rightViewController:rightPageController];
    self.deckController.delegate = self;
    self.deckController.leftSize =  120;
    self.deckController.rightSize = 94;
    self.window.rootViewController = self.deckController;
    application.statusBarHidden=NO;
    [self.window makeKeyAndVisible];
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];

    // [2]:注册APNS
    [self registerRemoteNotification];

    // [2-EXT]: 获取启动时收到的APN
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString *payloadMsg = [message objectForKey:@"payload"];
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        //NSLog(@"payloadMsg == %@",payloadMsg);
        NSLog(@"message == %@ %@",message,record);
    }
    //[self redirectNSlogToDocumentFolder];//写入NSLOG、的文件
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    //发送个推到服务器
    NSString * LoginUserNos = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    if (LoginUserNos) {
        //发送个推注册码
        NSString * clientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientId"];
        if (clientId) {
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            NSMutableDictionary * parame = [NSMutableDictionary dictionary];
            /**1userNo appType clientId appVersion*/
            parame[@"userNo"] = LoginUserNos;
            parame[@"appType"] = @(1);
            parame[@"clientId"] =clientId;
            //2.获取应用版本号
            float localVersion=[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
            parame[@"appVersion"] = @(localVersion);
            //3.发送给服务器
            [manager POST:@"http://file.ywsoftware.com:9090/T100040/login/loginBand" parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"success ==%@",responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error==%@",error);
            }];
        }
    }

    //灰色的背景
    bkImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [bkImageview addGestureRecognizer:tap];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes22:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [bkImageview addGestureRecognizer:rightSwipeGestureRecognizer];
    
    bkImageview.hidden = YES;
    bkImageview.backgroundColor = HAColor(57, 57, 57);
    bkImageview.alpha = 0;
    bkImageview.userInteractionEnabled = YES;
    [[[UIApplication sharedApplication].delegate window] addSubview:bkImageview];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"news.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:HAColor(226, 232, 237)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                           NSForegroundColorAttributeName:HAColor(57, 109, 154)}];

    return YES;
}

//添加滑动的手势
- (void)handleSwipes22:(UISwipeGestureRecognizer *)sender{
    [self.deckController toggleRightViewAnimated:YES];
}

#pragma mark --IIViewDeckControllerDelegate method-----
- (void)viewDeckController:(IIViewDeckController *)viewDeckController didChangeOffset:(CGFloat)offset orientation:(IIViewDeckOffsetOrientation)orientation panning:(BOOL)panning{
    CGFloat offset_right = offset*(-1);
    NSLog(@"orientation == %f",offset_right);
    bkImageview.alpha = 0.5;
    bkImageview.frame = CGRectMake(0, 0, ScreenWidth-offset_right, ScreenHeight);
}


- (void)viewDeckController:(IIViewDeckController *)viewDeckController didCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    if (viewDeckSide == 1) {
        NSLog(@"已经关闭左边");
    }
    
    if (viewDeckSide == 2) {
        NSLog(@"已经关闭右边");
        bkImageview.hidden = YES;
    }
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    if (viewDeckSide == 1) {
        NSLog(@"已经打开左边");
    }
    
    if (viewDeckSide == 2) {
        NSLog(@"已经打开右边");
    }
}

- (void)tapView:(UITapGestureRecognizer *)tap{
    [self.deckController toggleRightView];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didShowCenterViewFromSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    NSLog(@"显示主视图");
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController willCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    if (viewDeckSide == 1) {
        NSLog(@"将要关闭左边");
    }
    
    if (viewDeckSide == 2) {
        NSLog(@"将要关闭右边");
    }
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController willOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    if (viewDeckSide == 1) {
        NSLog(@"开始打开左边");
    }
    
    if (viewDeckSide == 2) {
        NSLog(@"开始打开右边");
        bkImageview.hidden = NO;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // [EXT] 切后台关闭SDK，让SDK第一时间断线，让个推先用APN推送
    [self stopSdk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //获取主视图
//    HANavigationController *navigationController = (HANavigationController *)[mainViewController.viewControllers objectAtIndex:0];
//    if ([navigationController.visibleViewController isKindOfClass:[HAMainViewController class]]) {
//        HAMainViewController *mainController = (HAMainViewController *)navigationController.visibleViewController;
//        [mainController refreshtheInterface];//刷新界面
//    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // [EXT] 重新上线
    [self startSdkWith:_appID appKey:_appKey appSecret:_appSecret];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

- (NSString *)currentLogFilePath
{
    NSMutableArray * listing = [NSMutableArray array];
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray * fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDirectory error:nil];
    if (!fileNames) {
        return nil;
    }

    for (NSString * file in fileNames) {
        if (![file hasPrefix:@"_log_"]) {
            continue;
        }

        NSString * absPath = [docsDirectory stringByAppendingPathComponent:file];
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:absPath isDirectory:&isDir]) {
            if (isDir) {
                [listing addObject:absPath];
            } else {
                [listing addObject:absPath];
            }
        }
    }

    [listing sortUsingComparator:^(NSString *l, NSString *r) {
        return [l compare:r];
    }];

    if (listing.count) {
        return [listing objectAtIndex:listing.count - 1];
    }

    return nil;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", _deviceToken);

    [[NSUserDefaults standardUserDefaults] setObject:_deviceToken forKey:DEVICETOKEN];
    // [3]:向个推服务器注册deviceToken
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:_deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:@""];
    }

    //[_mainVc logMsg:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    //[_mainVc logMsg:record];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];

    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];

    //NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];

    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    if (!_gexinPusher) {
        _sdkStatus = SdkStatusStoped;

        self.appID = appID;
        self.appKey = appKey;
        self.appSecret = appSecret;
        ;
        _clientId = nil;

        NSError *err = nil;
        _gexinPusher = [GexinSdk createSdkWithAppId:_appID
                                             appKey:_appKey
                                          appSecret:_appSecret
                                         appVersion:@"0.0.0"
                                           delegate:self
                                              error:&err];
        if (!_gexinPusher) {
            //[_mainVc logMsg:[NSString stringWithFormat:@"%@", [err localizedDescription]]];
        } else {
            _sdkStatus = SdkStatusStarting;
        }

        //[_mainVc updateStatusView:self];
    }
}

- (void)stopSdk{
    if (_gexinPusher) {
        [_gexinPusher destroy];
        _gexinPusher = nil;
        _sdkStatus = SdkStatusStoped;
        _clientId = nil;
        //[_mainVc updateStatusView:self];
    }
}

- (BOOL)checkSdkInstance
{
    if (!_gexinPusher) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"SDK未启动" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)setDeviceToken:(NSString *)aToken
{
    if (![self checkSdkInstance]) {
        return;
    }

    [_gexinPusher registerDeviceToken:aToken];
}

- (BOOL)setTags:(NSArray *)aTags error:(NSError **)error
{
    if (![self checkSdkInstance]) {
        return NO;
    }

    return [_gexinPusher setTags:aTags];
}

- (NSString *)sendMessage:(NSData *)body error:(NSError **)error {
    if (![self checkSdkInstance]) {
        return nil;
    }

    return [_gexinPusher sendMessage:body error:error];
}


- (void)testSdkFunction{
    //UIViewController *funcsView = [[TestFunctionController alloc] initWithNibName:@"TestFunctionController" bundle:nil];
    //[_naviController pushViewController:funcsView animated:YES];
    //[funcsView release];
}



#pragma mark - GexinSdkDelegate
- (void)GexinSdkDidRegisterClient:(NSString *)clientId{
    // [4-EXT-1]: 个推SDK已注册
   [[NSUserDefaults standardUserDefaults] setObject:clientId forKey:@"clientId"];
    NSLog(@"%@",@"个推消息已经注册");
}

- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId{
    // [4]: 收到个推消息
    LOG(@"收到个推消息");
    NSData *payload = [_gexinPusher retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
        NSLog(@"payloadMsg == %@",payloadMsg);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"安心汽车通知" message:@"请点击确定查看" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.accessibilityIdentifier = payloadMsg;
        alert.delegate = self;
        alert.tag = 1000;
        //[alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            NSLog(@"查看消息");
            //HAPushViewController *pushVC = [[HAPushViewController alloc] init];
            //pushVC.dataURL = alertView.accessibilityIdentifier;
            //pushVC.dataTitle = @"推送的消息";
            //[self.window.rootViewController presentViewController:pushVC animated:YES completion:nil];
        }
    }
}

- (void)GexinSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSLog(@"111111111");
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    //[_mainVc logMsg:record];
}

- (void)GexinSdkDidOccurError:(NSError *)error
{
    NSLog(@"2222222");
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    //[_mainVc logMsg:[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]];
}


- (void)redirectNSlogToDocumentFolder{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];// 注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

@end
