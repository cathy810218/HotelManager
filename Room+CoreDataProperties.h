//
//  Room+CoreDataProperties.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Room+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Room (CoreDataProperties)

+ (NSFetchRequest<Room *> *)fetchRequest;

@property (nonatomic) int16_t beds;
@property (nonatomic) int16_t number;
@property (nonatomic) float rate;
@property (nullable, nonatomic, retain) Hotel *hotel;
@property (nullable, nonatomic, retain) Reservation *reservation;

@end

NS_ASSUME_NONNULL_END
