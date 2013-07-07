//
//  DGUserTest.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGUserTest.h"
#import "DGUser+RestKit.h"
#import <CoreData/CoreData.h>

@implementation DGUserTest

- (void)testCreateUser
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSManagedObjectContext *moc = objectManager.managedObjectStore.mainQueueManagedObjectContext;
    DGUser * user = [NSEntityDescription insertNewObjectForEntityForName:@"DGUser" inManagedObjectContext:moc];
    user.userID = [[NSUUID UUID] UUIDString];
    user.createdAt = [NSDate date];
    user.username = @"exampleUser";
    user.password = @"secret phrase";
    user.phone = @"18912345678";
    user.email = @"example@dailygem.com";
    user.address = @"space";
    user.balance = @(1000000);
    
    [self waitForCompletion:@"Create New User" theCase:^{
        [objectManager postObject:user path:@"dgusers" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            STAssertEquals(operation.HTTPRequestOperation.response.statusCode, 200, @"Create New User status Code:%d", operation.HTTPRequestOperation.response.statusCode);
            self.isDone = YES;
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            STFail(@"error:%@", error);
            self.isDone = YES;
        }];
    } timeout:30];
}

@end
