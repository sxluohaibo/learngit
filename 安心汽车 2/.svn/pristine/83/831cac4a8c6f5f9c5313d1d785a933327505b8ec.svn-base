//
//  HAVersionModel.h
//  华奥移动
//
//  Created by un2lock on 15/3/6.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAVersionModel : NSObject
/*
 [{"vercode":"2.02","vername":"2.02","url":"http://www.che-henry.net/huaaomobileservice/ipa/huaaomobile v2.02(20141217).ipa","upgradetip":"版本 2.02正式发布 主要有如下更新:\n1.移动认证\n2.我的服务\n3.维修方案手机申请\n4.通知提醒功能\n5.新版通讯录\n6.其它界面修改或BUG修复\n点击确定即可进行升级"}]
 */
@property(nonatomic,copy) NSString* vercode;
@property(nonatomic,copy) NSString* vername;
@property(nonatomic,copy) NSString* url;
@property(nonatomic,copy) NSString* upgradetip;

+(instancetype)versionWithDict:(NSDictionary *)dict;
@end
