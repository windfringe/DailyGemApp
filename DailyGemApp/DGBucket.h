//
//  DGBucket.h
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DGDataObject;

@interface DGBucket : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) DGDataObject *dataObjects;

@end
