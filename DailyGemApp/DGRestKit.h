//
//  DGRestKit.h
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@protocol DGRestKitMappingDelegate <NSObject>
@optional
+ (RKObjectMapping *)serializationMappingDefinition;
+ (RKEntityMapping *)manageObjectMappingDefinition;

@end

@protocol DGRestKitDelegate <DGRestKitMappingDelegate>
+ (void)configureRouterDescrptor:(RKObjectManager *)objectManager;
@end

@protocol DGRestKitImporter <NSObject>
+ (BOOL)importSeedData:(RKManagedObjectImporter *)importer;
@end

@interface DGRestKit : NSObject

+ (void) InitRestKit;

+ (void) GenerateSeedDatabase;

+ (void) configureObjectManager:(RKObjectManager *)objectManager;
+ (void) replaceObject:(inout id *)mappableData forKeyPath:(NSString*)keyPath usingBlock:(void (^)(id* mappableData))block;

@end
