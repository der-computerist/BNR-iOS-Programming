//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Enrique Aliaga on 4/19/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRReminderViewController.h"

static NSString * const kDatePickerState = @"datePicker.date";

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

#pragma mark - Controller life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Get the tab bar item
        UITabBarItem *tbi = self.tabBarItem;

        // Give it a label
        tbi.title = @"Reminder";

        // Give it an image
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        tbi.image = i;

        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
    }

    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"BNRReminderViewController loaded its view.");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

#pragma mark - Button actions

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);

    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;

    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

#pragma mark - State restoration

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                                                            coder:(NSCoder *)coder
{
    return [[self alloc] init];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.datePicker.date forKey:kDatePickerState];
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.datePicker.date = (NSDate *)[coder decodeObjectForKey:kDatePickerState];
    
    [super decodeRestorableStateWithCoder:coder];
}

@end
