//
//  AppDelegate.m
//  HypnoNerd
//
//  Created by Enrique Aliaga on 4/16/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisViewController.h"
#import "BNRReminderViewController.h"
#import "BNRTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    return YES;
}


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"We just entered application:didFinishLaunchingWithOptions:");

    // If state restoration did not occur,
    // set up the view controller hierarchy
    if (!self.window.rootViewController) {
        BNRHypnosisViewController *hvc = [[BNRHypnosisViewController alloc] init];
        BNRReminderViewController *rvc = [[BNRReminderViewController alloc] init];

        BNRTabBarController *tabBarController = [[BNRTabBarController alloc] init];
        tabBarController.viewControllers = @[hvc, rvc];

        self.window.rootViewController = tabBarController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - State restoration

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}


- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}


- (UIViewController *)application:(UIApplication *)application
    viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
    coder:(NSCoder *)coder
{
    UIViewController *vc = [[BNRTabBarController alloc] init];

    if ([identifierComponents count] == 1) {
        self.window.rootViewController = vc;
    }

    return vc;
}


@end
