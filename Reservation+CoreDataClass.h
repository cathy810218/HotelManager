//
//  Reservation+CoreDataClass.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
