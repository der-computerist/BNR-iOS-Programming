//
//  BNRAssetTypeViewController.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 1/15/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import "BNRAssetTypeViewController.h"
#import "BNRItemStore.h"
#import "BNRItem+CoreDataClass.h"

@implementation BNRAssetTypeViewController

// designated initializer
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        UINavigationItem *navItem = self.navigationItem;

        // Create a new bar button item that will send addNewAssetType:
        // to BNRAssetTypeViewController.
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
            action:@selector(addNewAssetType:)];

        // Set this bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = bbi;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[[BNRItemStore sharedStore] allAssetTypes] count];
    } else {
        return [[[BNRItemStore sharedStore] itemsOfType:self.item.assetType] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Items of selected type:";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
        NSManagedObject *assetType = allAssets[indexPath.row];
        
        // Use key-value coding to get the asset type's label
        NSString *assetLabel = [assetType valueForKey:@"label"];
        cell.textLabel.text = assetLabel;
        
        // Checkmark the one that is currently selected
        if (assetType == self.item.assetType) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        // Get all items of the currently selected asset type
        if (self.item.assetType) {
            NSArray *itemsOfType = [[BNRItemStore sharedStore] itemsOfType:self.item.assetType];
            BNRItem *item = itemsOfType[indexPath.row];
            
            cell.textLabel.text = item.itemName;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
        NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
        NSManagedObject *assetType = allAssets[indexPath.row];
        
        // Set the selected asset type
        if ([self.delegate
            respondsToSelector:@selector(assetTypePickerController:didFinishPickingAssetType:)]) {
            [self.delegate assetTypePickerController:self didFinishPickingAssetType:assetType];
        }
    }
}

#pragma mark - Button actions

- (void)addNewAssetType:(id)sender
{
    UIAlertController *alertController = [UIAlertController
        alertControllerWithTitle:@"New Asset Type" message:@"Add a new asset type:"
        preferredStyle:UIAlertControllerStyleAlert];

    // Add a text field to the alert controller
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.placeholder = @"e.g. Electronics";
    }];

    // Add a "Cancel" button to the alert controller
    UIAlertAction *cancelAction = [UIAlertAction
        actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    // Add an "Add" button to the alert controller
    UIAlertAction *addAction = [UIAlertAction
        actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:
        ^(UIAlertAction * action) {
            // Create the new asset type
            NSManagedObject *newAssetType = [[BNRItemStore sharedStore] createAssetType];
            
            NSString *assetLabel = [alertController.textFields firstObject].text;
            [newAssetType setValue:assetLabel forKey:@"label"];
            
            // Instruct the table view to reload its data
            [self.tableView reloadData];
        }];
    [alertController addAction:addAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
