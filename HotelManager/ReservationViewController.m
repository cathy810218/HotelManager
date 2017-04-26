//
//  ReservationViewController.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "ReservationViewController.h"
#import "AutoLayout.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

@interface ReservationViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ReservationViewController

- (void)loadView
{
    [super loadView];
    [self setupTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];
    [AutoLayout fullScreenConstraintWithVFLForView:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


@end
