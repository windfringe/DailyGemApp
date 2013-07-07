//
//  DGDataObject.h
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DGBucket, DGItem;

@interface DGDataObject : NSManagedObject

@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) DGBucket *bucket;
@property (nonatomic, retain) NSSet *items;
@end

@interface DGDataObject (CoreDataGeneratedAccessors)

- (void)addItemsObject:(DGItem *)value;
- (void)removeItemsObject:(DGItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
