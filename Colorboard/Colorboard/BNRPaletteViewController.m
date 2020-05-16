//
//  BNRPaletteViewController.m
//  Colorboard
//
//  Created by Enrique Aliaga on 4/4/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import "BNRPaletteViewController.h"
#import "BNRColorViewController.h"
#import "BNRColorDescription.h"

@implementation BNRPaletteViewController

static NSMutableArray *_colors;

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.restorationClass = [self class];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Accessors

+ (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [NSMutableArray array];
        
        BNRColorDescription *cd = [[BNRColorDescription alloc] init];
        [_colors addObject:cd];
    }
    return _colors;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [BNRPaletteViewController.colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    BNRColorDescription *color = BNRPaletteViewController.colors[indexPath.row];
    cell.textLabel.text = color.name;
    
    return cell;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewColor"]) {
        
        // If we are adding a new color, create an instance
        // and add it to the colors array
        BNRColorDescription *color = [[BNRColorDescription alloc] init];
        [BNRPaletteViewController.colors addObject:color];
        
        // Then use the segue to set the color on the view controller
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        BNRColorViewController *mvc = (BNRColorViewController *)[nc topViewController];
        mvc.colorDescription = color;
        
    } else if ([segue.identifier isEqualToString:@"ExistingColor"]) {
        
        // For the push segue, the sender is the UITableViewCell
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        BNRColorDescription *color = BNRPaletteViewController.colors[ip.row];
        
        // Set the color, and also tell the view controller that this
        // is an existing color.
        BNRColorViewController *cvc = (BNRColorViewController *)segue.destinationViewController;
        cvc.colorDescription = color;
        cvc.existingColor = YES;
    }
}

#pragma mark - State restoration

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                                                            coder:(NSCoder *)coder
{
    BNRPaletteViewController *pvc = nil;
    
    UIStoryboard *storyboard =
        [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    if (storyboard) {
        pvc = (BNRPaletteViewController *)[storyboard
            instantiateViewControllerWithIdentifier:@"PaletteViewController"];
        pvc.restorationIdentifier = [identifierComponents lastObject];
        pvc.restorationClass = [self class];
    }
    return pvc;
}

@end
