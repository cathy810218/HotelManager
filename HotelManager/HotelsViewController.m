//
//  HotelsViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h" // for doing fetch

#import "Hotel+CoreDataProperties.h"
#import "Hotel+CoreDataClass.h"

#import "RoomsViewController.h"

@interface HotelsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *allHotels;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewController
{
    NSArray *_allHotels;
}

-(void)loadView
{
    [super loadView];
    // add table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self allHotels];
    
    // Because we don't have a stroyboard, so we set it's identifier here
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSArray *)allHotels
{
    if (!_allHotels) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        NSArray *hotels = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"There is an error fetching from core data");
        } else {
            NSLog(@"Fetch succeed!");
        }
        _allHotels = hotels;
    }
    return _allHotels;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Hotel *hotel = self.allHotels[indexPath.row];
    cell.textLabel.text = hotel.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allHotels count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomsViewController *roomVC = [[RoomsViewController alloc]init];
    roomVC.currSelectedHotel = self.allHotels[indexPath.row];
    
    [self.navigationController pushViewController:roomVC animated:true];
    
}

@end
