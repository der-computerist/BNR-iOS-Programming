//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Enrique Aliaga on 11/13/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BNRItemsViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    if ([super initWithStyle:UITableViewStyleGrouped]) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *backgroundImage = [UIImage imageNamed:@"water_drops.jpg"];
    UIView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = backgroundView;

    [self.tableView registerClass:[UITableViewCell class]
        forCellReuseIdentifier:@"UITableViewCell"];
}

# pragma mark - Headers

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]
        initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    headerView.backgroundColor = [UIColor whiteColor];

    CGPoint center = headerView.center;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerView.frame];
    titleLabel.center = center;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:32];

    if (tableView.numberOfSections > 1) {
        if (section == 0) {
            titleLabel.text = @"> $50";
        } else {
            titleLabel.text = @"<= $50";
        }
    } else {
        titleLabel.text = @"Items";
    }

    [headerView addSubview:titleLabel];
    return headerView;
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *allItems = [[BNRItemStore sharedStore] allItems];

    if ([allItems count] == 0) {
        return 1;  // need one section for the "No more items!" row
    } else{
        return [allItems count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *allItems = [[BNRItemStore sharedStore] allItems];

    if ([allItems count] == 0) {
        return 1;  // there are no items inside the allItems array and only one row is needed
                   // for the "No more items!" cell.
    }

    NSArray *itemsInSection = allItems[section];
    NSInteger numberOfRows;

    if (section == [tableView numberOfSections] - 1) {  // this is the last section. Add a row
        numberOfRows = [itemsInSection count] + 1;      // to account for the "No more items!" cell
    } else {
        numberOfRows = [itemsInSection count];
    }

    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
        forIndexPath:indexPath];

    NSArray *allItems = [[BNRItemStore sharedStore] allItems];
    NSInteger numberOfItemsInSection;

    if ([allItems count] == 0) {
        cell.textLabel.text = @"No more items!";
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:[UIFont systemFontSize]];
        return cell;
    } else {
        numberOfItemsInSection = [allItems[indexPath.section] count];
    }

    if (indexPath.section == [tableView numberOfSections] - 1
            && indexPath.row == numberOfItemsInSection) {
        cell.textLabel.text = @"No more items!";
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:[UIFont systemFontSize]];
    } else {
        BNRItem *item = allItems[indexPath.section][indexPath.row];
        cell.textLabel.text = [item description];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:20];
    }

    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    return cell;
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
        heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGFloat height = 60;
    NSArray *allItems = [[BNRItemStore sharedStore] allItems];
    NSInteger numberOfItemsInSection = [allItems[indexPath.section] count];

    if ([allItems count] == 0 ||
            (indexPath.section == [tableView numberOfSections] - 1
             && indexPath.row == numberOfItemsInSection)) {
        return tableView.rowHeight;
    }
    return height;
}

@end
