//
//  CoreDataStack.m
//  HotelManager
//
//  Created by Cathy Oun on 4/29/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel+CoreDataProperties.h"
#import "Hotel+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation CoreDataStack

@synthesize persistentContainer = _persistentContainer;

+ (instancetype)shared
{
    // We will need to nil out to avoid retain cycle
    static CoreDataStack *shared = nil;
    
    // Only execute one time!
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self seedCoreDataIfNeeded];
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    return self.persistentContainer.viewContext;
}

- (NSArray *)fetchFromCoreDataWithEntityName:(NSString *)name
{
    return [[CoreDataStack shared] fetchFromCoreDataWithEntityName:name withPredicate:nil];
}

- (NSArray *)fetchFromCoreDataWithEntityName:(NSString *)name
                               withPredicate:(NSPredicate *)predicate
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    request.predicate = predicate;
    
    NSError *fetchError;
    NSArray *result = [context executeFetchRequest:request error:&fetchError];
    
    if (fetchError) {
        NSLog(@"There is an error fetching from core data");
    } else {
        NSLog(@"Fetch succeed!");
    }
    return result;
}

- (NSFetchedResultsController *)fetchFromCoreDataWithEntityName:(NSString *)name
                                                  withPredicate:(NSPredicate *)predicate
                                                withDescriptors:(NSArray<NSSortDescriptor *>*)descriptors
                                    fetchWithSectionNameKeyPath:(NSString *)keyPath
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    
    request.predicate = predicate;
    request.sortDescriptors = descriptors;
    
    NSError *fetchError;
    NSFetchedResultsController *fetchController;
    //    result = [context executeFetchRequest:request error:&fetchError];
    fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:keyPath cacheName:nil];
    [fetchController performFetch:&fetchError];
    if (fetchError) {
        NSLog(@"There is an error fetching from core data");
    } else {
        NSLog(@"Fetch succeed!");
    }
    return fetchController;
}

- (void)seedCoreDataIfNeeded
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    
    NSError *error;
    NSInteger count = [self.managedObjectContext
                       countForFetchRequest:request
                       error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    if (count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hotels"
                                                         ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        NSError *jsonError;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:NSJSONWritingPrettyPrinted | NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) {
            NSLog(@"%@", jsonError.localizedDescription);
        }
        NSDictionary *hotels = jsonDict[@"Hotels"];
        
        
        for (NSDictionary *hotel in hotels) {
            
            Hotel *currentHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel"
                                                                inManagedObjectContext:self.managedObjectContext];
            
            currentHotel.name = hotel[@"name"];
            currentHotel.location = hotel[@"location"];
            currentHotel.stars = (NSInteger)hotel[@"stars"];
            
            for (NSDictionary *room in hotel[@"rooms"]) {
                Room *currentRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room"
                                                                  inManagedObjectContext:self.managedObjectContext];
                NSNumber *number = room[@"number"];
                currentRoom.number = [number integerValue];
                currentRoom.beds = (NSInteger)room[@"beds"];
                currentRoom.rate = (NSInteger)room[@"rate"];
                currentRoom.hotel = currentHotel;
            }
        }
        
        NSError *saveError;
        [self.managedObjectContext save:&saveError];
        if (saveError) {
            NSLog(@"Error saving to core data");
        } else {
            NSLog(@"Successfully saved to core data");
        }
    }
    
}

#pragma mark - Core Data stack


- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"HotelManager"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end
