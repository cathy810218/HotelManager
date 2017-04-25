//
//  RoomsViewController.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel+CoreDataProperties.h"
#import "Hotel+CoreDataClass.h"

@interface RoomsViewController : UIViewController
@property (strong, nonatomic) Hotel *currSelectedHotel;

@end
