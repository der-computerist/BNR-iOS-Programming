//
//  BNRAssetTypeViewController.h
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 1/15/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class BNRItem;

@interface BNRAssetTypeViewController : UITableViewController

@property (nonatomic) BNRItem *item;

@end
