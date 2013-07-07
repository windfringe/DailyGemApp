//
//  DGItem.h
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DGAuction, DGDataObject;

@interface DGItem : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * itemID;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * stock;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *auctions;
@end

@interface DGItem (CoreDataGeneratedAccessors)

- (void)addImagesObject:(DGDataObject *)value;
- (void)removeImagesObject:(DGDataObject *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addAuctionsObject:(DGAuction *)value;
- (void)removeAuctionsObject:(DGAuction *)value;
- (void)addAuctions:(NSSet *)values;
- (void)removeAuctions:(NSSet *)values;

@end
