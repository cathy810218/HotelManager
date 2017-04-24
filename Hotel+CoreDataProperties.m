//
//  Hotel+CoreDataProperties.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Hotel+CoreDataProperties.h"

@implementation Hotel (CoreDataProperties)

+ (NSFetchRequest<Hotel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
}

@dynamic location;
@dynamic stars;
@dynamic name;
@dynamic rooms;

@end
