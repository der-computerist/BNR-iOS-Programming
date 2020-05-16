//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by Enrique Aliaga on 4/3/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRColorDescription.h"

@interface BNRColorViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic) BOOL existingColor;
@property (nonatomic) BNRColorDescription *colorDescription;

@end
