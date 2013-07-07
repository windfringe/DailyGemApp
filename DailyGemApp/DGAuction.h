//
//  DGAuction.h
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DGItem;

@interface DGAuction : NSManagedObject

@property (nonatomic, retain) NSString * auctionID;
@property (nonatomic, retain) NSDate * openAt;
@property (nonatomic, retain) NSDate * closeAt;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) DGItem *item;
@property (nonatomic, retain) NSSet *bids;
@end

@interface DGAuction (CoreDataGeneratedAccessors)

- (void)addBidsObject:(NSManagedObject *)value;
- (void)removeBidsObject:(NSManagedObject *)value;
- (void)addBids:(NSSet *)values;
- (void)removeBids:(NSSet *)values;

@end
