//
//  AsyncSenTestCase.m
//  DailyGem
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "AsyncSenTestCase.h"


@implementation AsyncSenTestCase

- (void)waitForCompletion:(NSString *)desc theCase:(void (^)())theCase timeout:(NSTimeInterval)timeoutSecs
{
    _isDone = NO;
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    if(theCase) theCase();

    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!_isDone);
    
    STAssertTrue(_isDone, @"%@ Timeout" , desc);
}

@end
