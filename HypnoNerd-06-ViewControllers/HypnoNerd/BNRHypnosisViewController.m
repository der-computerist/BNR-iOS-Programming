//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Enrique Aliaga on 4/17/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController ()

@property (nonatomic, strong) UISegmentedControl *colorPicker;

@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";

        // Create the UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];

        // Put that image on the tab bar item
        self.tabBarItem.image = i;
    }

    return self;
}

- (void)loadView
{
    NSLog(@"BNRHypnosisViewController has been asked to load its view...");
    // Create a view
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    // Set it as *the* view of this view controller
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];

    NSLog(@"BNRHypnosisViewController loaded its view.");

    // Add a UISegmentedControl for picking colors
    self.colorPicker = [[UISegmentedControl alloc] initWithItems:@[@"Red", @"Green", @"Blue"]];
    [self.view addSubview:self.colorPicker];

    [self.colorPicker addTarget:self action:@selector(setColor:)
        forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.colorPicker.frame = CGRectMake(self.view.bounds.size.width / 4.0, 30,
        self.colorPicker.frame.size.width, self.colorPicker.frame.size.height);
}

- (void)setColor:(id)sender
{
    BNRHypnosisView *hypnosisView = (BNRHypnosisView *)self.view;
    
    switch ([sender selectedSegmentIndex]) {
        case 0:
            hypnosisView.circleColor = [UIColor redColor];
            break;

        case 1:
            hypnosisView.circleColor = [UIColor greenColor];
            break;

        default:
            hypnosisView.circleColor = [UIColor blueColor];
            break;
    }
}

@end
