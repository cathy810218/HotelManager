//
//  BookViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/25/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "BookViewController.h"
#import "AutoLayout.h"
#import "HotelService.h"
#import "MainViewController.h"

#import "Hotel+CoreDataProperties.h"
#import "HotelManager+CoreDataModel.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"

@interface BookViewController ()

@property (strong, nonatomic) UITextField *firstNameTextfield;
@property (strong, nonatomic) UITextField *lastNameTextfield;
@property (strong, nonatomic) UITextField *emailTextfield;

@end

@implementation BookViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Book the Room";
    [self setupTextfields];
    [self setupLabels];
    
    UIBarButtonItem *reserveButton = [[UIBarButtonItem alloc] initWithTitle:@"Reserve"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(reserveButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:reserveButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.firstNameTextfield resignFirstResponder];
    [self.lastNameTextfield resignFirstResponder];
    [self.emailTextfield resignFirstResponder];
}

- (void)reserveButtonPressed:(UIBarButtonItem *)sender
{
    [HotelService saveReservationWithFirstName:self.firstNameTextfield.text
                                      lastName:self.lastNameTextfield.text
                                         email:self.emailTextfield.text
                                          room:self.currSelectedRoom
                                     startDate:self.startDate
                                    andEndDate:self.endDate
                         withCompletionHandler:^(BOOL succeed) {
        if (succeed) {
            [self showAlertControllerWithSuccee:@"Success!"
                                    withMessage:@"Your reservation has been confirmed!"];
        } else {
            [self showAlertControllerWithSuccee:@"Fail..."
                                    withMessage:@"Something went wrong! We were not able to reserve your room."];
        }
    }];
}

- (void)showAlertControllerWithSuccee:(NSString *)title withMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupTextfields
{
    self.firstNameTextfield = ({
        UITextField *t = [[UITextField alloc] init];
        [self.view addSubview:t];
        [t setTranslatesAutoresizingMaskIntoConstraints:NO];
        t.placeholder = @"First Name";
        t.borderStyle = UITextBorderStyleRoundedRect;
        t;
    });
    
    self.lastNameTextfield = ({
        UITextField *t = [[UITextField alloc] init];
        [self.view addSubview:t];
        [t setTranslatesAutoresizingMaskIntoConstraints:NO];
        t.placeholder = @"Last Name";
        t.borderStyle = UITextBorderStyleRoundedRect;
        t;
    });
    self.emailTextfield = ({
        UITextField *t = [[UITextField alloc] init];
        [self.view addSubview:t];
        [t setTranslatesAutoresizingMaskIntoConstraints:NO];
        t.placeholder = @"Email";
        t.borderStyle = UITextBorderStyleRoundedRect;
        t;
    });

    [AutoLayout centerYFrom:self.emailTextfield
                     toView:self.view withOffset:0];
    [AutoLayout offest:-30
     forThisItemBottom:self.lastNameTextfield
         toThatItemTop:self.emailTextfield];
    
    [AutoLayout offest:-30
     forThisItemBottom:self.firstNameTextfield
         toThatItemTop:self.lastNameTextfield];
    
    [AutoLayout height:30 forView:self.firstNameTextfield];
    [AutoLayout height:30 forView:self.lastNameTextfield];
    [AutoLayout height:30 forView:self.emailTextfield];
    
    [AutoLayout centerXFrom:self.firstNameTextfield
                     toView:self.view
                 withOffset:0];
    [AutoLayout centerXFrom:self.lastNameTextfield
                     toView:self.view
                 withOffset:0];
    [AutoLayout centerXFrom:self.emailTextfield
                     toView:self.view
                 withOffset:0];
    
    [AutoLayout width:120 forView:self.firstNameTextfield];
    [AutoLayout width:120 forView:self.lastNameTextfield];
    [AutoLayout width:120 forView:self.emailTextfield];
}

- (void)setupLabels
{
    UILabel *roomLabel = [[UILabel alloc] init];
    [self.view addSubview:roomLabel];
    [roomLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    roomLabel.text = [NSString stringWithFormat:@"Hotel:    %@ - Room: %i", self.currSelectedRoom.hotel.name, self.currSelectedRoom.number];
    [AutoLayout height:30 forView:roomLabel];
    [AutoLayout centerXFrom:roomLabel toView:self.view withOffset:0];
    [AutoLayout centerYFrom:roomLabel toView:self.view withOffset:100];

    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    UILabel *checkInLabel = [[UILabel alloc] init];
    [self.view addSubview:checkInLabel];
    [checkInLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    checkInLabel.text = [NSString stringWithFormat:@"Check in:   %@", [dateFormat stringFromDate:self.startDate]];
    [AutoLayout offest:20 forThisItemTop:checkInLabel toThatItemBottom:roomLabel];
    [AutoLayout centerXFrom:checkInLabel toView:self.view withOffset:0];
    [AutoLayout height:30 forView:checkInLabel];

    
    UILabel *checkOutLabel = [[UILabel alloc] init];
    [self.view addSubview:checkOutLabel];
    [checkOutLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    checkOutLabel.text = [NSString stringWithFormat:@"Check out:   %@", [dateFormat stringFromDate:self.endDate]];
    [AutoLayout offest:20 forThisItemTop:checkOutLabel toThatItemBottom:checkInLabel];
    [AutoLayout centerXFrom:checkOutLabel toView:self.view withOffset:0];
    [AutoLayout height:30 forView:checkOutLabel];
}


// TODO: Regex to check user input

@end
