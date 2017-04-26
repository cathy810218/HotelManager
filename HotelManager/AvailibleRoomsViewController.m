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

@interface AvailibleRoomsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *availableRooms;

@end

@implementation AvailibleRoomsViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
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

- (NSArray *)availableRooms
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

        NSError *availableRoomsError;
        _availableRooms = [appDelegate.persistentContainer.viewContext executeFetchRequest:roomRequest error:&availableRoomsError];
        if (availableRoomsError) {
            NSLog(@"No available rooms");
        }
        
    }
    return _availableRooms;
}

#pragma mark: UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableRooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Room *room = self.availableRooms[indexPath.row];
    cell.textLabel.text = [[NSNumber numberWithInteger:room.number] stringValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookViewController *bookVC = [[BookViewController alloc] init];
    bookVC.currSelectedRoom = self.availableRooms[indexPath.row];
    [self.navigationController pushViewController:bookVC animated:YES];
}

@end
