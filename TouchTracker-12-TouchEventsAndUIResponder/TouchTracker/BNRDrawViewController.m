//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 3/13/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
