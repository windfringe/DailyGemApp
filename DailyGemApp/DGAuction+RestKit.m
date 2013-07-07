//
//  DGAuction+RestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGAuction+RestKit.h"
#import "DGBid+RestKit.h"
#import "DGItem+RestKit.h"

@implementation DGAuction (RestKit)

#pragma mark - DGRestKitDelegate

+ (RKEntityMapping *)manageObjectMappingDefinition
{
    RKManagedObjectStore *mos = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"DGAuction"
                                                   inManagedObjectStore:mos];
    mapping.identificationAttributes = @[@"auctionID"];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"auctionID"}];
    [mapping addAttributeMappingsFromArray:@[@"openAt", @"closeAt", @"price", @"status"]];

    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"item"
                                                 toKeyPath:@"item"
                                               withMapping:[DGItem manageObjectMappingDefinition]]];
    
    
    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"bids"
                                                 toKeyPath:@"bids"
                                               withMapping:[DGBid manageObjectMappingDefinition]]];
    
    return mapping;
}

+ (void)configureRouterDescrptor:(RKObjectManager *)objectManager
{
    RKEntityMapping *mapping = [self manageObjectMappingDefinition];
    
    [objectManager addResponseDescriptor:
     [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                             pathPattern:@"auctions"
                                                 keyPath:nil
                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
}


@end
