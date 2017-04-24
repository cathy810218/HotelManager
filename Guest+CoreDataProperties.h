//
//  Guest+CoreDataProperties.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Guest+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Guest (CoreDataProperties)

+ (NSFetchRequest<Guest *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Reservation *reservation;

@end

NS_ASSUME_NONNULL_END
