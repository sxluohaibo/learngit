//
//  CCQGlobalUICommon.h
//  MTime
//
//  Created by apple on 12-12-23.
//  Copyright (c) 2013年 ccq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTP @"http://"
#define MAIN_URL @"file.ywsoftware.com:9090"
#define HTTP_MAIN_URL @"http://file.ywsoftware.com:9090"
#define  MainURL @"http://file.ywsoftware.com:9090/T100040/"
//#define MAIN_URL @"172.16.10.18:8080"

#define TEN_DAYS @"72000"//十天有多少秒
#define APPID  @"975965157"
//友盟
#define UMENGID @"551222b4fd98c53e4e000464"
#define DEVICETOKEN  @"_deviceToken"
//个推的相关设置
#define kAppId           @"fN1tWEdQLp8uFwuSrUqfT9"
#define kAppKey          @"RIAOtbHJuL6b4kt35oEhS5"
#define kAppSecret       @"VE57FhVYrN6Byk8TLojb75"

#define DES_KEY  @"12345678"
#define USERLOGIN_SQLITE @"HALoginInfo.sqlite"
#define USERLOGIN_INFO @"userInfo"

#define CCQ_ROW_HEIGHT_ACTIVITYDETAIL    300
#define HAApplicationDelegate ((HAAppDelegate *)[UIApplication sharedApplication].delegate)
#define CCQ_ROW_HEIGHT_FRIENDSCELL_HEIGHT    50
#define STATEBAR_HEIGHT 20  //状态栏高度
#define TABBAR_HEIGHT 49  //自定义UITabBar的高度
#define NAVBAR_HEIGHT 44 //navagationBar的高度
#define TABBAR_TAP_BUTTON_WIDTH 64 //TabBar按钮的宽度
#define IPHONE_WIDTH 320  //设备像素宽度
#define IPHONE_HEIGHT 480 //设备高度
#define IPHONE5_HEIGHT 568 //iPhonoe5设备的高度

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define StateBarHeight 20
#define MainHeight (ScreenHeight - StateBarHeight)
#define MainWidth ScreenWidth

#define APPLICATIONWIDTH 320
#define APPLICATIONHeight ([[UIScreen mainScreen] bounds].size.height - StateBarHeight)
#define APPLICATIONHeight_IOS7 ([[UIScreen mainScreen] bounds].size.height)
#define bgMarginLeft 20
#define loginTextBgWidth  536
#define loginTextBgHeight 149

#define CCQ_ROW_HEIGHT_DETAILFRIEND_HEIGHT    APPLICATIONHeight

//判断ios7
#define IsIos7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)

//安全释放对象
#define RELEASE_SAFELY(__POINTER) { if(__POINTER){ [__POINTER release]; __POINTER = nil; }}

#define SAFE_STRING(str) ([(str) length] ? (str) : @"")

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//用于NSUserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//UIImage图片
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//颜色RGBA
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define NAVBAR_TOOLBAR_IMAGE_NAME   @"navBg"
#define NAVBAR_TOOLBAR_IMAGE_NAME_IOS7   @"navBg_ios7"

#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]


#ifndef NAV_BAR_ITEM_COLOR
#define NAV_BAR_ITEM_COLOR          ([UIColor lightGrayColor])

//点击热闹城市
#define ClickHotCityName @"ClickHotCityName" //（通知用）
#define RefreshCenterView @"refreshCenterView"//刷新中间的视图

//#define  choosecityName @"choosecityName"  //选择的城市
#define dwCityName @"dwCityName"  //定位城市
//#define  dwFail @"dwFail"  //定位失败
#define ClickViolationName @"ClickViolationName"//违章查询的城市 (通知用)
#define MainTenanceCarNameChoice @"MainTenanceCarNameChoice"//预约保养
#define CarClassPickNotification @"car select"   //车辆选择发送的通知 (通知用) lhb
#define MainTenanceCarTypeChoice @"MainTenanceCarTypeChoice" //车辆的选择
//数据库
#define AnXinQiCheDB @"AnXinQiChe.db"

#define ApplicationDelegate ((HAAppDelegate *)[UIApplication sharedApplication].delegate)

// RGB颜色
#define HAColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define HARandomColor HAColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define LoginUserNo @"Login_userNo"
#define LoginUserPhonenumer @"LoginUserPhonenumer"


//违章的数据
#define violationArea @"违章区域"
#define carTypeNO @"车牌号"
#define classNO @"车架号"
#define engineNo @"发动机号"
#define registerNO @"注册号"
#define remarkNO @"备注号"
#define carTYShort @"车牌简写"

#endif

