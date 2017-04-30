//
//  ReservationCell.h
//  HotelManager
//
//  Created by Cathy Oun on 4/29/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reservation+CoreDataClass.h"

@interface ReservationCell : UITableViewCell

@property (strong, nonatomic) Reservation *reservation;

@end
