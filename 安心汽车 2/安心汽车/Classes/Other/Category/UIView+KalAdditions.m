//
//  UIView+KalAdditions.m
//  qcsuqianribao
//
//  Created by kongwei on 14-6-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UIView+KalAdditions.h"

@implementation UIView (KalAdditions)

//得到此view 所在的viewController
- (UIViewController*)viewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
