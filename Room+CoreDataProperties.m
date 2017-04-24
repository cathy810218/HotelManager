//
//  Room+CoreDataProperties.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Room+CoreDataProperties.h"

@implementation Room (CoreDataProperties)

+ (NSFetchRequest<Room *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Room"];
}

@dynamic beds;
@dynamic number;
@dynamic rate;
@dynamic hotel;
@dynamic reservation;

@end
