//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 3/13/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"
#import "BNRColorPickerController.h"

@interface BNRDrawViewController ()

@end

@implementation BNRDrawViewController

# pragma mark - View life cycle

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]
        initWithTarget:self action:@selector(showColorPicker:)];
    swipeRecognizer.numberOfTouchesRequired = 3;
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    swipeRecognizer.delaysTouchesBegan = YES;
    [self.view addGestureRecognizer:swipeRecognizer];
}

# pragma mark - Gesture Recognizer action methods

- (void)showColorPicker:(UIGestureRecognizer *)gr
{
    BNRColorPickerController *colorPicker = [[BNRColorPickerController alloc] init];
    colorPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:colorPicker animated:YES completion:nil];
}

# pragma mark - Other methods

- (void)setNewLineColor:(UIColor *)color
{
    ((BNRDrawView *)self.view).selectedColor = color;
}

@end
