//
//  HotelService.h
//  HotelManager
//
//  Created by Cathy Oun on 4/30/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Guest+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"

@interface HotelService : NSObject


+ (NSFetchedResultsController *)getAllAvailableRoomWithStartDate:(NSDate *)startDate
                                                      andEndDate:(NSDate *)endDate;

+ (void)saveReservationWithFirstName:(NSString *)firstName
                            lastName:(NSString *)lastName
                               email:(NSString *)email
                                room:(Room *)room
                           startDate:(NSDate *)startDate
                          andEndDate:(NSDate *)endDate
               withCompletionHandler:(void (^)(BOOL succeed))completion;
@end
