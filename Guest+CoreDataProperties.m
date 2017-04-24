//
//  Guest+CoreDataProperties.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Guest+CoreDataProperties.h"

@implementation Guest (CoreDataProperties)

+ (NSFetchRequest<Guest *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Guest"];
}

@dynamic name;
@dynamic reservation;

@end
