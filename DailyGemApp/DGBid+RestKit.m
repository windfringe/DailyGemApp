//
//  DGBid+RestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGBid+RestKit.h"
#import "DGAuction+RestKit.h"
#import "DGUser+RestKit.h"

@implementation DGBid (RestKit)

#pragma mark - DGRestKitDelegate

+ (RKObjectMapping *)serializationMappingDefinition
{
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    [mapping addAttributeMappingsFromDictionary:@{
     @"bidID": @"id",
     @"bid.bidID": @"bidID",
     @"auction.auctionID": @"auctionID"}];
    [mapping addAttributeMappingsFromArray:@[@"price", @"biddenAt", @"status",@"settledAt"]];
    
    return mapping;
}

+ (RKEntityMapping *)manageObjectMappingDefinition
{
    RKManagedObjectStore *mos = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"DGBid"
                                                   inManagedObjectStore:mos];
    mapping.identificationAttributes = @[@"bidID"];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"bidID"}];
    [mapping addAttributeMappingsFromArray:@[@"price", @"biddenAt", @"status",@"settledAt"]];
    
    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"bidder"
                                                 toKeyPath:@"bidder"
                                               withMapping:[DGUser manageObjectMappingDefinition]]];

    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"auction"
                                                 toKeyPath:@"auction"
                                               withMapping:[DGAuction manageObjectMappingDefinition]]];
    
    return mapping;
}

+ (void)configureRouterDescrptor:(RKObjectManager *)objectManager
{
    RKEntityMapping *mapping = [self manageObjectMappingDefinition];
    
    [objectManager addResponseDescriptor:
     [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                             pathPattern:@"bids"
                                                 keyPath:nil
                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    RKObjectMapping *requestMapping = [self serializationMappingDefinition];
    [objectManager addRequestDescriptor:
     [RKRequestDescriptor requestDescriptorWithMapping:requestMapping
                                           objectClass:[self class]
                                           rootKeyPath:nil]];
}

@end
