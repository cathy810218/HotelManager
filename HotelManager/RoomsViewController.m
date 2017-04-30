//
//  RoomsViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//
#import "AutoLayout.h"
#import "RoomsViewController.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@interface RoomsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation RoomsViewController

- (void)loadView
{
    [super loadView];
    self.navigationItem.title = @"Rooms";
    [self setupTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    self.rooms = [[[self.currSelectedHotel rooms] allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [AutoLayout fullScreenConstraintWithVFLForView:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Room *room = self.rooms[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%i", room.number];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rooms.count;
}

@end
