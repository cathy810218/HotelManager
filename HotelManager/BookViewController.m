//
//  BookViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/25/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "BookViewController.h"
#import "AutoLayout.h"

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
}


- (void)reserveButtonPressed:(UIBarButtonItem *)sender
{
    // save
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    
//    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
//    
//    Guest *guestForReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
//    guestForReservation.lastName = self.lastNameTextfield.text;
//    guestForReservation.firstName = self.firstNameTextfield.text;
//    reservation.guest = guestForReservation;
//    
//    reservation.startDate = self.startDate;
//    reservation.endDate = self.endDate;
//    reservation.room = self.currSelectedRoom;
//    MainMenuViewController *mainMenuVC = [[MainMenuViewController alloc]init];
//    //  NSLog(@"last name %@", reservation.guest.lastName);
//    //  NSLog(@"start date %@", reservation.startDate);
//    //  NSLog(@"hotel %@", reservation.room.hotel.name);
//    //  NSLog(@"room number%@", reservation.room.number);
//    
//    NSError *saveError;
//    BOOL result = [appDelegate.coreDataStack.managedObjectContext save:&saveError];
//    if (!result) {
//        NSLog(@" %@",saveError.localizedDescription);
//    }
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Your reservation has been confirmed!" preferredStyle:UIAlertControllerStyleAlert];
//    
//    
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
//                               {
//                                   [self.navigationController pushViewController:mainMenuVC animated:true];
//                               }];
//    
//    [alertController addAction:okAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupTextfields
{
    UITextField *first = [[UITextField alloc] init];
    UITextField *last =  [[UITextField alloc] init];
    UITextField *email = [[UITextField alloc] init];
    
    [self.view addSubview:first];
    [self.view addSubview:last];
    [self.view addSubview:email];
    
    [first setTranslatesAutoresizingMaskIntoConstraints:NO];
    [last setTranslatesAutoresizingMaskIntoConstraints:NO];
    [email setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    first.placeholder = @"First Name";
    last.placeholder = @"Last Name";
    email.placeholder = @"Email";
    
    first.borderStyle = UITextBorderStyleRoundedRect;
    last.borderStyle = UITextBorderStyleRoundedRect;
    email.borderStyle = UITextBorderStyleRoundedRect;
    
    [AutoLayout centerYFrom:email toView:self.view withOffset:0];
    [AutoLayout offest:-30 forThisItemBottom:first toThatItemTop:email];
    [AutoLayout offest:-30 forThisItemBottom:last toThatItemTop:first];
    
    [AutoLayout height:30 forView:first];
    [AutoLayout height:30 forView:last];
    [AutoLayout height:30 forView:email];
    
    [AutoLayout centerXFrom:first toView:self.view withOffset:0];
    [AutoLayout centerXFrom:last toView:self.view withOffset:0];
    [AutoLayout centerXFrom:email toView:self.view withOffset:0];
    
    [AutoLayout width:120 forView:first];
    [AutoLayout width:120 forView:last];
    [AutoLayout width:120 forView:email];
    
    self.firstNameTextfield = first;
    self.lastNameTextfield = last;
    self.emailTextfield = email;
}

- (void)setupLabels
{
    UILabel *roomLabel = [[UILabel alloc] init];
    [self.view addSubview:roomLabel];
    [roomLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    roomLabel.text = [NSString stringWithFormat:@"Hotel:    %@ - Room: %i",self.currSelectedRoom.hotel.name, self.currSelectedRoom.number];
    
    [AutoLayout height:30 forView:roomLabel];
    [AutoLayout centerXFrom:roomLabel toView:self.view withOffset:0];
    [AutoLayout centerYFrom:roomLabel toView:self.view withOffset:100];
    
    UILabel *checkInLabel = [[UILabel alloc] init];
    UILabel *checkOutLabel = [[UILabel alloc] init];
    
    [self.view addSubview:checkInLabel];
    [self.view addSubview:checkOutLabel];
    
    [checkInLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [checkOutLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    checkInLabel.text = [NSString stringWithFormat:@"Check in:   %@", [dateFormat stringFromDate:self.startDate]];
    checkOutLabel.text = [NSString stringWithFormat:@"Check out:   %@", [dateFormat stringFromDate:self.endDate]];
    
    [AutoLayout offest:20 forThisItemTop:checkInLabel toThatItemBottom:roomLabel];
    [AutoLayout offest:20 forThisItemTop:checkOutLabel toThatItemBottom:checkInLabel];
    [AutoLayout centerXFrom:checkInLabel toView:self.view withOffset:0];
    [AutoLayout centerXFrom:checkOutLabel toView:self.view withOffset:0];
    
    [AutoLayout height:30 forView:checkInLabel];
    [AutoLayout height:30 forView:checkOutLabel];

}



@end
