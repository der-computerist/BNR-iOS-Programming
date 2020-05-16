//
//  BNRColorPickerController.m
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 5/15/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRColorPickerController.h"
#import "BNRDrawViewController.h"

@interface BNRColorPickerController ()

@end

@implementation BNRColorPickerController

- (IBAction)setLineColor:(UIButton *)sender
{
    BNRDrawViewController *presentingVC = (BNRDrawViewController *)self.presentingViewController;
    [presentingVC setNewLineColor:sender.backgroundColor];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
