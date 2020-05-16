//
//  AppDelegate.m
//  Hypnosister
//
//  Created by Enrique Aliaga on 1/17/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisView.h"

@interface AppDelegate () <UIScrollViewDelegate>

@property (strong, nonatomic) BNRHypnosisView *hypnosisView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *wvc = [[UIViewController alloc] init];
    self.window.rootViewController = wvc;
    
    // Create CGRects for frames
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    bigRect.size.height *= 2.0;

    // Create a screen-sized scroll view and add it to the window
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [wvc.view addSubview:scrollView];
    
    // Create a super-sized hypnosis view and add it to the scroll view
    self.hypnosisView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
    [scrollView addSubview:self.hypnosisView];

    // Tell the scroll view how big its content area is
    scrollView.contentSize = bigRect.size;

    // Tell the scroll view who its delegate is
    scrollView.delegate = self;

    // Configure the zoom scale
    CGFloat widthScale = scrollView.bounds.size.width / self.hypnosisView.bounds.size.width;
    CGFloat heightScale = scrollView.bounds.size.height / self.hypnosisView.bounds.size.height;
    CGFloat minScale = MIN(widthScale, heightScale);
    scrollView.minimumZoomScale = minScale;
    scrollView.zoomScale = minScale;
    
    self.window.backgroundColor = [UIColor whiteColor];
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.hypnosisView;
}

@end
