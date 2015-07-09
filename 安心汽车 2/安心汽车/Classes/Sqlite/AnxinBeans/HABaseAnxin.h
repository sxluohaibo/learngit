//
//  HABaseAnxin.h
//  安心汽车
//
//  Created by kongw on 15/3/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HABaseAnxin : NSObject{
    FMDatabase	*db;
}
@property(nonatomic,retain) FMDatabase	*db;

-(BOOL) openDatabase;
-(void) closeDatabase;
@end
