//
//  HotelsViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h" // Ask to do fetch

#import "Hotel+CoreDataProperties.h"
#import "Hotel+CoreDataClass.h"
#import "AutoLayout.h"

@interface HotelsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *allHotels;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewController

-(void)loadView
{
    [super loadView];
    // add table view
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    // Because we don't have a stroyboard, so we set it's identifier here
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSArray *)allHotels
{
    if (!_allHotels) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotels"];
        
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allHotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

@end
