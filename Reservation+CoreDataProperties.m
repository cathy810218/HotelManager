//
//  Reservation+CoreDataProperties.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Reservation+CoreDataProperties.h"

@implementation Reservation (CoreDataProperties)

+ (NSFetchRequest<Reservation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
}

@dynamic startDate;
@dynamic endDate;
@dynamic room;
@dynamic guest;

@end
