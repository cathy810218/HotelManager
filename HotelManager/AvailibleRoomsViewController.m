//
//  AvailibleRoomsViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/25/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "AvailibleRoomsViewController.h"
#import "BookViewController.h"
#import "AppDelegate.h"
#import "AutoLayout.h"

#import "Room+CoreDataProperties.h"
#import "Room+CoreDataClass.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

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
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, [NSDate date]];
        
        NSError *roomError;
        NSArray *results = [appDelegate.persistentContainer.viewContext executeFetchRequest:request error:&roomError];
        
        NSMutableArray *unavailiableRooms = [NSMutableArray new];
        
        for (Reservation *reservation in results) {
            [unavailiableRooms addObject:reservation];
        }
        
        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailiableRooms]; // self = rooms

        NSSortDescriptor *roomSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES];
        NSSortDescriptor *roomNumberSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];

        roomRequest.sortDescriptors = @[roomSortDescriptor, roomNumberSortDescriptor];
        
        
        
        NSError *availableRoomsError;
//        _availableRooms = [appDelegate.persistentContainer.viewContext executeFetchRequest:roomRequest error:&availableRoomsError];
        _availableRooms = [[NSFetchedResultsController alloc] initWithFetchRequest:roomRequest
                                                              managedObjectContext:appDelegate.persistentContainer.viewContext
                                                                sectionNameKeyPath:@"hotel.name"
                                                                         cacheName:nil];
        [_availableRooms performFetch:&availableRoomsError];
        if (availableRoomsError) {
            NSLog(@"No available rooms");
        }
        
    }
    return _availableRooms;
}

#pragma mark: UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];
//    return [self.availableRooms fetchedObjects].count;
    return sectionInfo.numberOfObjects;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Room *room = [self.availableRooms objectAtIndexPath:indexPath];
//    Room *room = rooms[indexPath.row];
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
