//
//  QuestionModelFrame.h
//  提问列表demo1
//
//  Created by un2lock on 15/4/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"



@class QuestionModel;
#define HAStatusCellYXBYFont [UIFont systemFontOfSize:15]
#define HAStatusCellCarFont [UIFont systemFontOfSize:12]
@interface QuestionModelFrame : NSObject

@property (nonatomic, strong) QuestionModel *questionModel;

/** iconView */
@property (nonatomic, assign) CGRect iconViewF;
/** carNoView */
@property (nonatomic, assign) CGRect carNoViewF;
/** wxbyView */
@property (nonatomic, assign) CGRect wxbyViewF;
/** carRankView */
@property (nonatomic, assign) CGRect carRankViewF;
/** questionNoteView */
@property (nonatomic, assign) CGRect questionNoteViewF;
/** timeView */
@property (nonatomic, assign) CGRect timeViewF;
/** resultView */
@property (nonatomic, assign) CGRect questionFlagViewF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
