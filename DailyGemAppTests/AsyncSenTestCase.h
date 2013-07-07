//
//  AsyncSenTestCase.h
//  DailyGem
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface AsyncSenTestCase : SenTestCase
@property (assign) BOOL isDone;

- (void)waitForCompletion:(NSString *)desc theCase:(void (^)())theCase timeout:(NSTimeInterval)timeoutSecs;
@end
