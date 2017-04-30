//
//  HotelsViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "HotelsViewController.h"
#import "CoreDataStack.h"
#import "AutoLayout.h"
#import "Hotel+CoreDataProperties.h"
#import "Hotel+CoreDataClass.h"

#import "RoomsViewController.h"

@interface HotelsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *allHotels;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewController

-(void)loadView
{
    [super loadView];
    self.navigationItem.title = @"Hotels";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [self setupTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Because we don't have a stroyboard, so we set it's identifier here
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [AutoLayout fullScreenConstraintWithVFLForView:self.tableView];
}


- (NSArray *)allHotels
{
    if (!_allHotels) {
        NSArray *result = [[CoreDataStack shared] fetchFromCoreDataWithEntityName:@"Hotel"];
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
//        
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
//        
//        NSError *fetchError;
//        NSArray *hotels = [context executeFetchRequest:request error:&fetchError];
//        
//        if (fetchError) {
//            NSLog(@"There is an error fetching from core data");
//        } else {
//            NSLog(@"Fetch succeed!");
//        }
        _allHotels = result;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomsViewController *roomVC = [[RoomsViewController alloc]init];
    roomVC.currSelectedHotel = self.allHotels[indexPath.row];
    
    [self.navigationController pushViewController:roomVC animated:YES];
}

@end
