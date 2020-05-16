//
//  BNRDateChangeViewController.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 2/18/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRDateChangeViewController.h"
#import "BNRItem.h"

@interface BNRDateChangeViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDateChangeViewController

- (instancetype)init
{
    if ([super init]) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Date Change";
    }
    return self;
}

# pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.date = self.item.dateCreated;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.item.dateCreated = self.datePicker.date;
}

@end
