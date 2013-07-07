//
//  DGUser.h
//  DailyGemApp
//
//  Created by gbo on 13-7-8.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DGBid;

@interface DGUser : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *bids;
@end

@interface DGUser (CoreDataGeneratedAccessors)

- (void)addBidsObject:(DGBid *)value;
- (void)removeBidsObject:(DGBid *)value;
- (void)addBids:(NSSet *)values;
- (void)removeBids:(NSSet *)values;

@end
