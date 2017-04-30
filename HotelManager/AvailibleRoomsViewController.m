//
//  AvailibleRoomsViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/25/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "AvailibleRoomsViewController.h"
#import "BookViewController.h"
#import "AutoLayout.h"
#import "HotelService.h"

#import "Room+CoreDataProperties.h"
#import "Room+CoreDataClass.h"

@interface AvailibleRoomsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *availableRooms;

@end

@implementation AvailibleRoomsViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Available Rooms";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [self setupTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];
    [AutoLayout fullScreenConstraintWithVFLForView:self.tableView];
}

- (NSFetchedResultsController *)availableRooms
{
    if (!_availableRooms) {
        _availableRooms = [HotelService getAllAvailableRoomWithStartDate:self.startDate
                                                              andEndDate:self.endDate];
    }
    return _availableRooms;
}

#pragma mark: UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];

    return sectionInfo.numberOfObjects;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Room *room = [self.availableRooms objectAtIndexPath:indexPath];
    cell.textLabel.text = [[NSNumber numberWithInteger:room.number] stringValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookViewController *bookVC = [[BookViewController alloc] init];
    bookVC.currSelectedRoom    = [self.availableRooms objectAtIndexPath:indexPath];
    bookVC.startDate           = self.startDate;
    bookVC.endDate             = self.endDate;
    [self.navigationController pushViewController:bookVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.availableRooms.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];
    return sectionInfo.name;
}

@end
