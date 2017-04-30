//
//  HotelService.m
//  HotelManager
//
//  Created by Cathy Oun on 4/30/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "HotelService.h"
#import "CoreDataStack.h"
#import "Reservation+CoreDataProperties.h"
#import "Reservation+CoreDataClass.h"

@implementation HotelService


+ (NSFetchedResultsController *)getAllAvailableRoomWithStartDate:(NSDate *)startDate
                                                      andEndDate:(NSDate *)endDate
{
    CoreDataStack *coreData = [CoreDataStack shared];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", startDate, endDate];
    
    NSArray *reservations = [coreData fetchFromCoreDataWithEntityName:@"Reservation" withPredicate:predicate];
    
    NSMutableArray *unavailableRooms = [[NSMutableArray alloc] init];
    
    for (Reservation *reservation in reservations) {
        [unavailableRooms addObject:reservation];
    }
    
    NSPredicate *availableRoomPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    
    NSSortDescriptor *roomSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES];
    NSSortDescriptor *roomNumberSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    
    NSFetchedResultsController *result = [coreData fetchFromCoreDataWithEntityName:@"Room" withPredicate:availableRoomPredicate withDescriptors:@[roomSortDescriptor, roomNumberSortDescriptor] fetchWithSectionNameKeyPath:@"hotel.name"];
    
    return result;
}


+ (void)saveReservationWithFirstName:(NSString *)firstName
                            lastName:(NSString *)lastName
                               email:(NSString *)email
                                room:(Room *)room
                           startDate:(NSDate *)startDate
                          andEndDate:(NSDate *)endDate
               withCompletionHandler:(void (^)(BOOL succeed))completion
{
    NSManagedObjectContext *context = [CoreDataStack shared].managedObjectContext;
    Guest *guest = ({
        Guest *g = [NSEntityDescription insertNewObjectForEntityForName:@"Guest"
                                                 inManagedObjectContext:context];
        g.firstName = firstName;
        g.lastName = lastName;
        g.email = email;
        g;
    });
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation"
                                                       inManagedObjectContext: context];
        reservation.startDate = startDate;
        reservation.endDate = endDate;
        reservation.room = room;
        reservation.guest = guest;
 
    
    NSError *saveError;
    BOOL result = [context save:&saveError];
    if (!result) {
        NSLog(@"%@", saveError.localizedDescription);
    }
    
    if (!saveError) {
        completion(YES);
    } else {
        completion(NO);
    }
}


@end
