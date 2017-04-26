//
//  DatePickerViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AutoLayout.h"
#import "AvailibleRoomsViewController.h"

@interface DatePickerViewController ()

@property (strong, nonatomic) UIDatePicker *startDate;
@property (strong, nonatomic) UIDatePicker *endDate;

@end

@implementation DatePickerViewController

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupDatePicker];
    [self setupDoneButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupDatePicker
{
    self.startDate = [[UIDatePicker alloc] init];
    self.startDate.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.startDate];
    [self.startDate setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [AutoLayout height:200 forView:self.startDate];
    [AutoLayout leadingConstraintFrom:self.startDate toView:self.view];
    [AutoLayout trailingConstraintFrom:self.startDate toView:self.view];
    [AutoLayout offest:50 forThisItemTop:self.startDate toThatItemBottom:self.topLayoutGuide];
    [AutoLayout centerYFrom:self.startDate toView:self.view withOffset:-100];
    
    self.endDate = [[UIDatePicker alloc] init];
    self.endDate.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.endDate];
    [self.endDate setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [AutoLayout height:200 forView:self.endDate];
    [AutoLayout leadingConstraintFrom:self.endDate toView:self.view];
    [AutoLayout trailingConstraintFrom:self.endDate toView:self.view];
    [AutoLayout centerYFrom:self.endDate toView:self.view withOffset:150];
}

- (void)setupDoneButton
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)doneButtonPressed:(UIBarButtonItem *)sender
{
    NSDate *endDate = self.endDate.date;
    if ([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        self.endDate.date = [NSDate date];
        return;
    }
    AvailibleRoomsViewController *avaVC = [[AvailibleRoomsViewController alloc] init];
    avaVC.startDate = [NSDate date];
    avaVC.endDate = [self.endDate date];
    [self.navigationController pushViewController:avaVC animated:YES];
}

@end
