//
//  MainViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "MainViewController.h"
#import "AutoLayout.h"
#import "HotelsViewController.h"
#import "DatePickerViewController.h"
#import "ReservationViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) UIButton *browseButton;
@property (strong, nonatomic) UIButton *bookButton;
@property (strong, nonatomic) UIButton *lookupButton;


@end

@implementation MainViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)setupButtons
{
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton   = [self createButtonWithTitle:@"Book"];
    UIButton *lookupButton = [self createButtonWithTitle:@"Look up"];
    
    browseButton.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1];
    bookButton.backgroundColor = [UIColor redColor];
    lookupButton.backgroundColor = [UIColor grayColor];
    
    
    [browseButton addTarget:self
                     action:@selector(browseButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [bookButton addTarget:self
                   action:@selector(bookButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    
    [lookupButton addTarget:self
                     action:@selector(lookupButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    self.browseButton = browseButton;
    self.bookButton = bookButton;
    self.lookupButton = lookupButton;
    
    [self updateButtonLayout];
}

- (void)updateViewConstraints
{
    [self updateButtonLayout];
    [super updateViewConstraints];
}

- (void)updateButtonLayout
{
    [AutoLayout offest:0.0 forThisItemTop:self.browseButton toThatItemBottom:self.topLayoutGuide];
    
    [AutoLayout leadingConstraintFrom:self.browseButton toView:self.view];
    [AutoLayout trailingConstraintFrom:self.browseButton toView:self.view];
    
    [AutoLayout equalHeightConstraintFromView:self.bookButton toView:self.browseButton withMultiplier:1.0];
    [AutoLayout leadingConstraintFrom:self.bookButton toView:self.view];
    [AutoLayout trailingConstraintFrom:self.bookButton toView:self.view];
    [AutoLayout offest:0.0 forThisItemTop:self.bookButton toThatItemBottom:self.browseButton];
    
    [AutoLayout equalHeightConstraintFromView:self.lookupButton toView:self.browseButton withMultiplier:1.0];
    [AutoLayout leadingConstraintFrom:self.lookupButton toView:self.view];
    [AutoLayout trailingConstraintFrom:self.lookupButton toView:self.view];
    [AutoLayout offest:0.0 forThisItemTop:self.lookupButton toThatItemBottom:self.bookButton];
    
    [AutoLayout bottomConstraintFrom:self.lookupButton toView:self.view];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.view setNeedsUpdateConstraints];
}

- (void)browseButtonPressed
{
    HotelsViewController *hotelVC = [[HotelsViewController alloc] init];
    [self.navigationController pushViewController: hotelVC animated:YES];
}

- (void)bookButtonPressed
{
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc] init];
    [self.navigationController pushViewController: datePickerVC animated:YES];
}

- (void)lookupButtonPressed
{
    ReservationViewController *reservationVC = [[ReservationViewController alloc] init];
    [self.navigationController pushViewController: reservationVC animated:YES];
}

- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    return button;
}

@end
