//
//  QuestionDetailViewController.h
//  提问列表demo1
//
//  Created by un2lock on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModelFrame.h"
#import "QuestionModel.h"
@interface QuestionDetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  提问id
 */
@property(nonatomic,copy) NSString *questionIdStr;
@property(nonatomic,strong) QuestionModelFrame *questionModelFrame;
@end
