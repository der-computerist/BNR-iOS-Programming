//
//  BNRColorViewController.m
//  Colorboard
//
//  Created by Enrique Aliaga on 4/3/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import "BNRColorViewController.h"
#import "BNRPaletteViewController.h"

@interface BNRColorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation BNRColorViewController

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.restorationClass = [self class];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Remove the 'Done' button if this is an existing color
    if (self.existingColor) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    UIColor *color = self.colorDescription.color;
    
    // Get the RGB values out of the UIColor object
    float red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
    // Set the initial slider values
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    
    // Set the background color and text field value
    self.view.backgroundColor = color;
    self.textField.text = self.colorDescription.name;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.colorDescription.name = self.textField.text;
    self.colorDescription.color = self.view.backgroundColor;
}

#pragma mark - Button actions

- (IBAction)changeColor:(id)sender
{
    float red = self.redSlider.value;
    float green = self.greenSlider.value;
    float blue = self.blueSlider.value;
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.view.backgroundColor = newColor;
}

- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - State restoration

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                                                            coder:(NSCoder *)coder
{
    BNRColorViewController *cvc = nil;
    
    UIStoryboard *storyboard =
        [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    if (storyboard) {
        cvc = (BNRColorViewController *)[storyboard
            instantiateViewControllerWithIdentifier:@"ColorViewController"];
        cvc.restorationIdentifier = [identifierComponents lastObject];
        cvc.restorationClass = [self class];
    }
    return cvc;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeBool:self.existingColor forKey:@"ColorExists"];
    [coder encodeObject:self.colorDescription.name forKey:@"color.name"];
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.existingColor = [coder decodeBoolForKey:@"ColorExists"];
    
    NSString *colorName = [coder decodeObjectForKey:@"color.name"];
    for (BNRColorDescription *color in BNRPaletteViewController.colors) {
        if ([colorName isEqualToString:color.name]) {
            self.colorDescription = color;
        }
    }
    
    [super decodeRestorableStateWithCoder:coder];
}

@end
