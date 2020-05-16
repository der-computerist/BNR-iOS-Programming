//
//  BNRPaletteViewController.h
//  Colorboard
//
//  Created by Enrique Aliaga on 4/4/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRPaletteViewController : UITableViewController <UIViewControllerRestoration>

@property (class, nonatomic, copy, readonly) NSMutableArray *colors;

@end
