//
//  Constant.h
//  01-QQ聊天界面
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//


//#define UserId @"20150417144258965412"


//#define MyAccount @"20150417144258965412"
//点击了提问内容提交
#define ClickSubmitBtnToNet @"ClickSubmitBtnToNet"

#ifdef DEBUG // 调试状态, 打开LOG功能
#define HALog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define HALog(...)
#endif