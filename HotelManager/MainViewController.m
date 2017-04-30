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
    self.navigationItem.title = @"Hotel Manager";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [self setupButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)setupButtons
{
    self.browseButton = ({
        UIButton *b = [self createButtonWithTitle:@"Browse"];
        [b addTarget:self
              action:@selector(browseButtonPressed)
    forControlEvents:UIControlEventTouchUpInside];
        [b setImage:[UIImage imageNamed:@"hotel"]
           forState:UIControlStateNormal];
        [b.imageView setContentMode:UIViewContentModeScaleAspectFill];
        b;
    });
    
    
    self.bookButton = ({
        UIButton *b = [self createButtonWithTitle:@"Book"];
        [b addTarget:self
              action:@selector(bookButtonPressed)
    forControlEvents:UIControlEventTouchUpInside];
        [b setImage:[UIImage imageNamed:@"room"]
           forState:UIControlStateNormal];
        [b.imageView setContentMode:UIViewContentModeScaleAspectFill];
        b;
    });
    
    self.lookupButton = ({
        UIButton *b = [self createButtonWithTitle:@"Look up"];
        [b addTarget:self
              action:@selector(lookupButtonPressed)
    forControlEvents:UIControlEventTouchUpInside];
        [b setImage:[UIImage imageNamed:@"food"]
           forState:UIControlStateNormal];
        [b.imageView setContentMode:UIViewContentModeScaleAspectFill];
        b;
    });
    
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
    
    [self addContentViewForButton:self.browseButton];
    [self addContentViewForButton:self.bookButton];
    [self addContentViewForButton:self.lookupButton];
}

- (void)addContentViewForButton:(UIButton *)btn
{
    UIView *dimView = [[UIView alloc] init];
    [btn addSubview:dimView];
    [dimView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout topConstraintFrom:dimView toView:btn];
    [AutoLayout bottomConstraintFrom:dimView toView:btn];
    [AutoLayout leadingConstraintFrom:dimView toView:btn];
    [AutoLayout trailingConstraintFrom:dimView toView:btn];
    dimView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    dimView.userInteractionEnabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [btn addSubview:titleLabel];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [AutoLayout bottomConstraintFrom:titleLabel toView:btn];
    [AutoLayout leadingConstraintFrom:titleLabel toView:btn];
    [AutoLayout trailingConstraintFrom:titleLabel toView:btn];
    [AutoLayout height:50 forView:titleLabel];
    titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    titleLabel.text = btn.titleLabel.text;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = [UIFont fontWithName:@"Zapfino" size:18];
    
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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    return button;
}

@end
