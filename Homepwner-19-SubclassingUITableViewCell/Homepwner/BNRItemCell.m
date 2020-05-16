//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 10/2/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
