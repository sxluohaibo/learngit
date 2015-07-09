//
//  HA4sFrame.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/28.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HA4SRequestResult;

@interface HA4sFrame : NSObject

@property(nonatomic,strong) HA4SRequestResult * message;
@property(nonatomic,assign,readonly) CGRect titleF;
@property(nonatomic,assign,readonly) CGRect iconF;
@property(nonatomic,assign,readonly) CGRect detailTitleF;
@property(nonatomic,assign,readonly) CGRect timeTitleF;
@property(nonatomic,assign,readonly) CGFloat cellHeight;

+(instancetype)FrameWith4SRequestResult:(HA4SRequestResult *)item;

- (instancetype)initWithDuty:(HA4SRequestResult *)item;


@end
