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
@property (strong, nonatomic) NSMutableArray *roomNumbers;

@end

@implementation RoomsViewController

- (void)loadView
{
    [super loadView];
    [self setupTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.roomNumbers = [[NSMutableArray alloc] init];
    self.rooms = [[self.currSelectedHotel rooms] allObjects];
    for (Room *room in self.rooms) {
        [self.roomNumbers addObject: [NSNumber numberWithUnsignedInt:room.number]];
    }
    self.roomNumbers = [[self.roomNumbers sortedArrayUsingSelector:@selector(compare:)] mutableCopy];

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
    cell.textLabel.text = [self.roomNumbers[indexPath.row] stringValue];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rooms.count;
}

@end
