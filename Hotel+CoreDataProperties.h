//
//  Hotel+CoreDataProperties.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Hotel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Hotel (CoreDataProperties)

+ (NSFetchRequest<Hotel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *location;
@property (nonatomic) int16_t stars;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Room *> *rooms;

@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(Room *)value;
- (void)removeRoomsObject:(Room *)value;
- (void)addRooms:(NSSet<Room *> *)values;
- (void)removeRooms:(NSSet<Room *> *)values;

@end

NS_ASSUME_NONNULL_END
