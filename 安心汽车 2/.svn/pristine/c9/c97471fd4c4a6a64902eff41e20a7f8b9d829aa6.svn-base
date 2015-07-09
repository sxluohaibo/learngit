//
//  HADeduction.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  扣分行为

#import "HADeduction.h"

@implementation HADeduction




+ (instancetype)itemWithTitle:(NSString *)title
{
    
    HADeduction * item = [[self alloc] init];
    item.title = title;
    return item;
    
}


+ (instancetype)itemWithTitle:(NSString *)title withHtml:(NSString *)html destVcClass:(Class)destVcClass
{
    HADeduction * item = [self itemWithTitle:title withHtml:html];
    item.destVcClass = destVcClass;
    
    return item;
}



+ (instancetype)itemWithTitle:(NSString *)title withHtml:(NSString *)html{
    
    HADeduction * item = [self itemWithTitle:title];
    item.html = html;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass{
    
    HADeduction * item = [self itemWithTitle:title];
    item.destVcClass = destVcClass;
    return item;
}
@end
