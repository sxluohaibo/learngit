//
//  HADeduction.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  扣分行为

#import <Foundation/Foundation.h>

@interface HADeduction : NSObject




/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;


/**
 *  网页名称
 */
@property (nonatomic, copy) NSString *html;

/**
 *  点击挑转的控制器
 */
@property (nonatomic, assign) Class destVcClass;


+ (instancetype)itemWithTitle:(NSString *)title withHtml:(NSString *)html destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title withHtml:(NSString *)html;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;
@end
