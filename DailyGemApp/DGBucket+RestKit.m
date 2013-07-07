//
//  DGBucket+RestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGBucket+RestKit.h"

@implementation DGBucket (RestKit)

#pragma mark - DGRestKitMappingDelegate

+ (RKEntityMapping *)manageObjectMappingDefinition
{
    RKManagedObjectStore *mos = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"DGBucket"
                                                   inManagedObjectStore:mos];
    mapping.identificationAttributes = @[@"title"];
    [mapping addAttributeMappingsFromArray:@[@"title"]];
    
    return mapping;
}

@end
