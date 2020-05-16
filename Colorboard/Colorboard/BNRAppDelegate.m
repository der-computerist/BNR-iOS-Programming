//
//  BNRAppDelegate.m
//  Colorboard
//
//  Created by Enrique Aliaga on 4/1/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"

@interface BNRAppDelegate ()

@end

@implementation BNRAppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
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
    UINavigationController *nav = nil;
    
    NSString *storyboardID = nil;
    if ([identifierComponents count] == 1) {
        storyboardID = @"RootNavController";
    } else {
        storyboardID = @"ModalNavController";
    }
    
    UIStoryboard *storyboard =
        [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    if (storyboard) {
        nav = (UINavigationController *)[storyboard
            instantiateViewControllerWithIdentifier:storyboardID];
        nav.restorationIdentifier = [identifierComponents lastObject];
    }
    
    if ([identifierComponents count] == 1) {
        self.window.rootViewController = nav;
    }
    
    return nav;
}

@end
