//
//  BookViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/25/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "BookViewController.h"

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
    [self setupTextfields];
    [self setupLabels];
}

- (void)setupTextfields
{
    
}

- (void)setupLabels
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
