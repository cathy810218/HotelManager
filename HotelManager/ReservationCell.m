//
//  ReservationCell.m
//  HotelManager
//
//  Created by Cathy Oun on 4/29/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "ReservationCell.h"
#import "Reservation+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Room+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "AutoLayout.h"

@interface ReservationCell ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *hotelLabel;
@property (strong, nonatomic) UILabel *roomLabel;

@end

@implementation ReservationCell

- (void)setReservation:(Reservation *)reservation
{
    
    _reservation = reservation;
    
    _nameLabel = [[UILabel alloc] init];
    [self addSubview:_nameLabel];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout offest:8 forThisItemTop:self.nameLabel toThatItemTop:self];
    [AutoLayout offest:8 forThisItemLeading:self.nameLabel toThatItemLeading:self];
    [AutoLayout offest:8 forThisItemTrailing:self.nameLabel toThatItemTrailing:self];
    [AutoLayout height:20 forView:self.nameLabel];
    
    _hotelLabel = [[UILabel alloc] init];
    [self addSubview:_hotelLabel];
    [self.hotelLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout offest:8 forThisItemTop:self.hotelLabel toThatItemBottom:self.nameLabel];
    [AutoLayout offest:8 forThisItemLeading:self.hotelLabel toThatItemLeading:self];
    [AutoLayout offest:8 forThisItemTrailing:self.hotelLabel toThatItemTrailing:self];
    [AutoLayout height:20 forView:self.hotelLabel];
    
    
    self.roomLabel = [[UILabel alloc] init];
    [self addSubview:self.roomLabel];
    [self.roomLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout offest:8 forThisItemTop:self.roomLabel toThatItemBottom:self.hotelLabel];
    [AutoLayout offest:8 forThisItemLeading:self.roomLabel toThatItemLeading:self];
    [AutoLayout offest:8 forThisItemTrailing:self.roomLabel toThatItemTrailing:self];
    [AutoLayout height:20 forView:self.roomLabel];
    [AutoLayout offest:-8 forThisItemBottom:self.roomLabel toThatItemBottom:self];
    
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [self.reservation guest].firstName, [self.reservation guest].lastName];
    self.hotelLabel.text =[NSString stringWithFormat:@"Hotel: %@",[[self.reservation room] hotel].name];
    self.roomLabel.text = [NSString stringWithFormat:@"Room: %i",[self.reservation room].number];
}

- (void)prepareForReuse
{
    self.nameLabel = nil;
    self.hotelLabel = nil;
    self.roomLabel = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
