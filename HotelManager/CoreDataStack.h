//
//  CoreDataStack.h
//  HotelManager
//
//  Created by Cathy Oun on 4/29/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

+ (instancetype)shared;
- (void)saveContext;
- (instancetype) initForTesting;

- (NSArray *)fetchFromCoreDataWithEntityName:(NSString *)name;
- (NSArray *)fetchFromCoreDataWithEntityName:(NSString *)name
                               withPredicate:(NSPredicate *)predicate;

- (NSFetchedResultsController *)fetchFromCoreDataWithEntityName:(NSString *)name
                                                  withPredicate:(NSPredicate *)predicate
                                                withDescriptors:(NSArray<NSSortDescriptor *>*)descriptors
                                    fetchWithSectionNameKeyPath:(NSString *)keyPath;
@end
