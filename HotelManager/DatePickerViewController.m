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

@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endDatePicker;

@end

@implementation DatePickerViewController

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupDatePicker];
    [self setupDoneButton];
    [self setupDateLabels];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startDatePicker.date = [NSDate date];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    self.endDatePicker.date = [[NSDate date] dateByAddingTimeInterval:secondsPerDay];
    [self.startDatePicker addTarget:self
                             action:@selector(pickerChanged:)
                   forControlEvents:UIControlEventValueChanged];
}

- (void)pickerChanged:(UIDatePicker *)sender
{
    if ([self.startDatePicker.date timeIntervalSinceReferenceDate] < [[NSDate date] timeIntervalSinceReferenceDate]) {
        // Start day in the past. Then set it to today's day
        self.startDatePicker.date = [NSDate date];
    }
    
    if ([self.endDatePicker.date timeIntervalSinceReferenceDate] <= [self.startDatePicker.date timeIntervalSinceReferenceDate]) {
        // End day is in the past than the start date, then move it to 1 day after the start date
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        self.endDatePicker.date = [self.startDatePicker.date dateByAddingTimeInterval:secondsPerDay];
    }
}

- (void)setupDateLabels
{
    UILabel *startDateLabel = [[UILabel alloc] init];
    UILabel *endDateLabel = [[UILabel alloc] init];
    [self.view addSubview:startDateLabel];
    [self.view addSubview:endDateLabel];
    [startDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [endDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    startDateLabel.text = @"Check In";
    endDateLabel.text = @"Check Out";
    startDateLabel.textAlignment = NSTextAlignmentCenter;
    endDateLabel.textAlignment = NSTextAlignmentCenter;
    
    [AutoLayout leadingConstraintFrom:startDateLabel toView:self.view];
    [AutoLayout trailingConstraintFrom:startDateLabel toView:self.view];
    [AutoLayout height:30 forView:startDateLabel];
    [AutoLayout offest:20 forThisItemTop:startDateLabel toThatItemBottom:self.topLayoutGuide];
    [AutoLayout offest:0 forThisItemBottom:startDateLabel toThatItemTop:self.startDatePicker];
    
    
    [AutoLayout offest:0 forThisItemBottom:endDateLabel toThatItemTop:self.endDatePicker];
    [AutoLayout leadingConstraintFrom:endDateLabel toView:self.view];
    [AutoLayout trailingConstraintFrom:endDateLabel toView:self.view];
    [AutoLayout height:30 forView:endDateLabel];

}

- (void)setupDatePicker
{
    self.startDatePicker = [[UIDatePicker alloc] init];
    self.startDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.startDatePicker];
    [self.startDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.endDatePicker = [[UIDatePicker alloc] init];
    self.endDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.endDatePicker];
    [self.endDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [AutoLayout leadingConstraintFrom:self.startDatePicker toView:self.view];
    [AutoLayout trailingConstraintFrom:self.startDatePicker toView:self.view];

    [AutoLayout offest:40 forThisItemTop:self.endDatePicker toThatItemBottom:self.startDatePicker];
    [AutoLayout equalHeightConstraintFromView:self.endDatePicker toView:self.startDatePicker withMultiplier:1.0];

    [AutoLayout leadingConstraintFrom:self.endDatePicker toView:self.view];
    [AutoLayout trailingConstraintFrom:self.endDatePicker toView:self.view];
    [AutoLayout offest:-20 forThisItemBottom:self.endDatePicker toThatItemBottom:self.view];
    
}

- (void)setupDoneButton
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)doneButtonPressed:(UIBarButtonItem *)sender
{
    NSDate *endDate = self.endDatePicker.date;
    if ([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        self.endDatePicker.date = [NSDate date];
        return;
    }
    AvailibleRoomsViewController *avaVC = [[AvailibleRoomsViewController alloc] init];
    avaVC.startDate = [NSDate date];
    avaVC.endDate = [self.endDatePicker date];
    [self.navigationController pushViewController:avaVC animated:YES];
}

@end
