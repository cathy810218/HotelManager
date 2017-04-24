//
//  Reservation+CoreDataProperties.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Reservation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reservation (CoreDataProperties)

+ (NSFetchRequest<Reservation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, retain) Room *room;
@property (nullable, nonatomic, retain) Guest *guest;

@end

NS_ASSUME_NONNULL_END
