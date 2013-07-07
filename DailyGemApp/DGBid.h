//
//  DGBid.h
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DGAuction, DGUser;

@interface DGBid : NSManagedObject

@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSDate * biddenAt;
@property (nonatomic, retain) NSDate * status;
@property (nonatomic, retain) NSDate * settledAt;
@property (nonatomic, retain) NSString * bidID;
@property (nonatomic, retain) DGAuction *auction;
@property (nonatomic, retain) DGUser *bidder;

@end
