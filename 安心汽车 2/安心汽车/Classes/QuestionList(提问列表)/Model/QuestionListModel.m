//
//  QuestionListModel.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "QuestionListModel.h"
#import "QuestionModel.h"

@implementation QuestionListModel
//- (id)init{
//    self = [super init];
//    if (self) {
//        _questionList = [[NSArray alloc] init];
//    }
//    return self;
//}
-(NSDictionary *)objectClassInArray{
    return @{@"questionList" : [QuestionModel class]};
}
@end
