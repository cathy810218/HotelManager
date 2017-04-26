//
//  BookViewController.h
//  HotelManager
//
//  Created by Cathy Oun on 4/25/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@interface BookViewController : UIViewController

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) Room *currSelectedRoom;

@end
