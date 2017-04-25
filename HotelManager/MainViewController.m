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

@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLayout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)setupLayout
{    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton   = [self createButtonWithTitle:@"Book"];
    UIButton *lookupButton = [self createButtonWithTitle:@"Look up"];
    CGFloat height = (self.view.bounds.size.height - 64) / 3;
    CGFloat width = self.view.bounds.size.width;
    
    browseButton.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1];
    bookButton.backgroundColor = [UIColor redColor];
    lookupButton.backgroundColor = [UIColor grayColor];
    
    [AutoLayout leadingConstraintFrom:browseButton toView:self.view];
    [AutoLayout trailingConstraintFrom:browseButton toView:self.view];
    [AutoLayout offest:64 forViewTop:browseButton toViewTop:self.view];
    [AutoLayout height:height forView:browseButton];
 
    [AutoLayout height:height forView:bookButton];
    [AutoLayout width:width forView:bookButton];
    [AutoLayout offest:0 forViewTop:bookButton toViewBottom:browseButton];
    
    
    [AutoLayout height:height forView:lookupButton];
    [AutoLayout width:width forView:lookupButton];
    [AutoLayout offest:0 forViewTop:lookupButton toViewBottom:bookButton];
    
    [browseButton addTarget:self
                     action:@selector(browseButtonSelected)
           forControlEvents:UIControlEventTouchUpInside];
    
    [bookButton addTarget:self
                     action:@selector(bookButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [lookupButton addTarget:self
                     action:@selector(lookupButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
}

- (void)bookButtonPressed
{
    
}

- (void)lookupButtonPressed
{
    
}

- (void)browseButtonSelected
{
    HotelsViewController *hotelVC = [[HotelsViewController alloc] init];
    [self.navigationController pushViewController: hotelVC animated:YES];
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
