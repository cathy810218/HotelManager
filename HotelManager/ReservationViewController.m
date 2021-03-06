//
//  ReservationViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "ReservationViewController.h"
#import "AutoLayout.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Room+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "CoreDataStack.h"
#import "ReservationCell.h"

@interface ReservationViewController () <UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *allReservations;
@property (strong, nonatomic) NSMutableArray *filteredReservation;
@property (strong, nonatomic) ReservationCell *reservationCell;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ReservationViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSearchBar];
    [self setupTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Search Your Reservation";
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}

- (NSArray *)allReservations
{
    if (!_allReservations) {
        _allReservations = [[CoreDataStack shared] fetchFromCoreDataWithEntityName:@"Reservation"];
    }
    return _allReservations;
}

- (void)setupSearchBar
{
    self.searchBar = [[UISearchBar alloc] init];
    [self.view addSubview:self.searchBar];
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.searchBar.placeholder = @"Enter first name, last name or email";
    self.searchBar.showsCancelButton = YES;
    [AutoLayout offest:0 forThisItemTop:self.searchBar toThatItemBottom:self.topLayoutGuide];
    [AutoLayout leadingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout trailingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout height:40 forView:self.searchBar];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerClass:[ReservationCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setEstimatedRowHeight:100];
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
    [AutoLayout leadingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout trailingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout bottomConstraintFrom:self.tableView toView:self.view];
    [AutoLayout offest:0 forThisItemTop:self.tableView toThatItemBottom:self.searchBar];
}

#pragma mark - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filteredReservation = [[NSMutableArray alloc]init];
    self.filteredReservation = [[self.allReservations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"guest.lastName CONTAINS[c] %@ OR guest.firstName CONTAINS[c] %@ OR guest.email CONTAINS[c] %@", searchBar.text, searchBar.text, searchBar.text]] mutableCopy];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    self.filteredReservation = nil;
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text != nil) {
        self.filteredReservation = [[NSMutableArray alloc]init];
        self.filteredReservation = [[self.allReservations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"guest.lastName CONTAINS[c] %@ OR guest.firstName CONTAINS[c] %@ OR guest.email CONTAINS[c] %@", searchBar.text, searchBar.text, searchBar.text]] mutableCopy];
    }
    NSLog(@"Search Clicked");
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.filteredReservation != nil) {
        return self.filteredReservation.count;
    }
    return self.allReservations.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReservationCell *reservationCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    Reservation *reservation;
    if (self.filteredReservation == nil) {
        reservation = self.allReservations[indexPath.row];
    } else {
        reservation = self.filteredReservation[indexPath.row];
    }
    
    if (reservationCell == nil) {
        reservationCell = [[ReservationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    reservationCell.reservation = reservation;

    return reservationCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end

