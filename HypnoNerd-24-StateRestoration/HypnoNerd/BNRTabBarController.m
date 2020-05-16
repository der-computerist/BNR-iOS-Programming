//
//  BNRTabBarController.m
//  HypnoNerd
//
//  Created by Enrique Aliaga Chavez on 2/18/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import "BNRTabBarController.h"
#import "BNRHypnosisViewController.h"
#import "BNRReminderViewController.h"

static NSString * const kChildViewController0 = @"childVC0";
static NSString * const kChildViewController1 = @"childVC1";

@implementation BNRTabBarController

#pragma mark - Controller life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.restorationIdentifier = NSStringFromClass([self class]);
    }
    
    return self;
}

#pragma mark - State restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.viewControllers[0] forKey:kChildViewController0];
    [coder encodeObject:self.viewControllers[1] forKey:kChildViewController1];

    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    BNRHypnosisViewController *hvc = [coder decodeObjectForKey:kChildViewController0];
    BNRReminderViewController *rvc = [coder decodeObjectForKey:kChildViewController1];

    self.viewControllers = @[ hvc, rvc ];

    [super decodeRestorableStateWithCoder:coder];
}

@end
