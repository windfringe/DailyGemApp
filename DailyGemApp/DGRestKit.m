//
//  DGRestKit.m
//  DailyGemApp
//
//  Created by gbo on 13-7-7.
//  Copyright (c) 2013年 DailyGem. All rights reserved.
//

#import "DGRestKit.h"

NSString *kManagedObjectModelName = @"DailyGem";
NSString *kStoreFile = @"DailyGemData.sqlite";

@implementation DGRestKit

+ (void) configureObjectManager:(RKObjectManager *)objectManager
{
    //NODEJS date format
    //2012-02-14T13:36:55.000Z
    [RKEntityMapping addDefaultDateFormatterForString:@"yyyy-MM-dd'T'hh:mm:ss.SSS'Z'" inTimeZone:nil];
    // Setup our object mappings
    
    NSArray *entities = objectManager.managedObjectStore.managedObjectModel.entities;
    
    for (NSEntityDescription *entityDescription in entities) {
        Class entityClass = NSClassFromString(entityDescription.name);
        if ([entityClass conformsToProtocol:@protocol(DGRestKitDelegate)]) {
            [entityClass configureRouterDescrptor:objectManager];
        }
    }
}

+ (RKManagedObjectStore *)managedObjectStore
{
	NSError *error;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kManagedObjectModelName withExtension:@"momd"];
    // NOTE: Due to an iOS 5 bug, the managed object model returned is immutable.
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:kStoreFile];
    NSPersistentStore __unused *persistentStore =
    [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                fromSeedDatabaseAtPath:nil
                                     withConfiguration:nil
                                               options:nil
                                                 error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    return managedObjectStore;
}

+ (void)GenerateSeedDatabase
{
    NSString *seedDatabasePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:kStoreFile];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:seedDatabasePath]) {
        return;
    }
    
	NSError *error = nil;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kManagedObjectModelName withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add memory persistent store: %@", error);
    [managedObjectStore createManagedObjectContexts];
    [RKObjectManager sharedManager].managedObjectStore =  managedObjectStore;
    
    RKManagedObjectImporter *importer = [[RKManagedObjectImporter alloc] initWithManagedObjectModel:managedObjectModel storePath:seedDatabasePath];
    NSArray *entities = managedObjectModel.entities;
    for (NSEntityDescription *entityDescription in entities) {
        Class entityClass = NSClassFromString(entityDescription.name);
        if ([entityClass conformsToProtocol:@protocol(DGRestKitImporter)]) {
            [entityClass importSeedData:importer];
        }
    }
}

+ (void) InitRestKit {
    NSString *webserviceURL = [NSString stringWithFormat:@"http://127.0.0.1:%u/", 5000];
	RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:webserviceURL]];
    [RKObjectManager setSharedManager:objectManager];
//    [self GenerateSeedDatabase];
    objectManager.managedObjectStore = [self managedObjectStore];
    
    // Enable automatic network activity indicator management
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelDebug);
    
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    [self configureObjectManager:objectManager];
}

#pragma mark - Override mapping data function
+ (BOOL)isTypeACollection:(Class)type
{
    Class orderedSetClass = NSClassFromString(@"NSOrderedSet");
    return (type && ([type isSubclassOfClass:[NSSet class]] ||
                     [type isSubclassOfClass:[NSArray class]] ||
                     (orderedSetClass && [type isSubclassOfClass:orderedSetClass])));
}

+ (BOOL)isValueACollection:(id)value
{
    return [self isTypeACollection:[value class]];
}

+ (void)replaceObject:(inout id *)mappableData forKeyPath:(NSString*)keyPath usingBlock:(void (^)(id* mappableData))block
{
    id originObject = [*mappableData valueForKey:keyPath];
    if (originObject) {
        id newObject = nil;
        if ([self isValueACollection:originObject]) {
            NSArray* originArray = originObject;
            NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:[originArray count]];
            for(NSDictionary* dictionary in originArray) {
                NSMutableDictionary* newDictionary = [dictionary mutableCopy];
                block(&newDictionary);
                [newArray addObject:newDictionary];
            }
            newObject = newArray;
        } else {
            newObject = [originObject mutableCopy];
            block(&newObject);
        }
        
        [*mappableData removeObjectForKey:keyPath];
        [*mappableData setObject:newObject forKey:keyPath];
    }
}

@end
