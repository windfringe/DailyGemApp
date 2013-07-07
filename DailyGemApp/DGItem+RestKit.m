//
//  DGItem+RestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGItem+RestKit.h"
#import "DGDataObject+RestKit.h"

@implementation DGItem (RestKit)

#pragma mark - DGRestKitMappingDelegate

+ (RKEntityMapping *)manageObjectMappingDefinition
{
    RKManagedObjectStore *mos = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"DGItem"
                                                   inManagedObjectStore:mos];
    mapping.identificationAttributes = @[@"itemID"];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"itemID"}];
    [mapping addAttributeMappingsFromArray:@[@"desc",@"price",@"stock",@"title"]];
 
    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"images"
                                                 toKeyPath:@"images"
                                               withMapping:[DGDataObject manageObjectMappingDefinition]]];
    
    return mapping;
}

@end
