//
//  DGUser+RestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGUser+RestKit.h"
#import "DGAuction+RestKit.h"

@implementation DGUser (RestKit)

#pragma mark - DGRestKitDelegate

+ (RKObjectMapping *)serializationMappingDefinition
{
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    [mapping addAttributeMappingsFromDictionary:@{@"userID": @"id"}];
    [mapping addAttributeMappingsFromArray:@[@"address", @"balance", @"createdAt",@"email",@"password",@"phone", @"username"]];
    
    return mapping;
}

+ (RKEntityMapping *)manageObjectMappingDefinition
{
    RKManagedObjectStore *mos = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"DGUser"
                                                   inManagedObjectStore:mos];
    mapping.identificationAttributes = @[@"userID"];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"userID"}];
    [mapping addAttributeMappingsFromArray:@[@"address", @"balance", @"createdAt",@"email",@"password",@"phone", @"username"]];
    
    [mapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"bids"
                                                 toKeyPath:@"bids"
                                               withMapping:[DGAuction manageObjectMappingDefinition]]];

    return mapping;
}

+ (void)configureRouterDescrptor:(RKObjectManager *)objectManager
{
    RKEntityMapping *mapping = [self manageObjectMappingDefinition];
    
    [objectManager addResponseDescriptor:
     [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                             pathPattern:@"users"
                                                 keyPath:nil
                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    RKObjectMapping *requestMapping = [self serializationMappingDefinition];
    [objectManager addRequestDescriptor:
     [RKRequestDescriptor requestDescriptorWithMapping:requestMapping
                                           objectClass:[self class]
                                           rootKeyPath:nil]];
}


@end
