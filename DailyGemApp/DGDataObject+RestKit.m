//
//  DGDataObject+RestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGDataObject+RestKit.h"
#import "DGBucket+RestKit.h"

@implementation DGDataObject (RestKit)

#pragma mark - DGRestKitMappingDelegate

+ (RKEntityMapping *)manageObjectMappingDefinition
{
    RKManagedObjectStore *mos = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"DGDataObject"
                                                   inManagedObjectStore:mos];
    mapping.identificationAttributes = @[@"title"];
    [mapping addAttributeMappingsFromArray:@[@"title",@"size",@"type"]];

    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"bucket"
                                                 toKeyPath:@"bucket"
                                               withMapping:[DGBucket manageObjectMappingDefinition]]];
    
    return mapping;
}

@end
