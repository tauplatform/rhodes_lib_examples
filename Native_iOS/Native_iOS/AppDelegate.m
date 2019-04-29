//
//  AppDelegate.m
//  Native_iOS
//
//  Created by Dmitry Soldatenkov on 29/04/2019.
//  Copyright © 2019 TAU Technologies. All rights reserved.
//

#import "AppDelegate.h"

#import <Rhodes/Rhodes.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"$$$ Call Rhodes initialize asynchronously ...");
        [[RhodesLib getSharedInstance] startRhodes:application];
        NSLog(@"$$$ Rhodes framewrok and embedded Rhodes application initialized !");
    });
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [[RhodesLib getSharedInstance] applicationWillResignActive:application];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[RhodesLib getSharedInstance] applicationDidEnterBackground:application];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [[RhodesLib getSharedInstance] applicationWillEnterForeground:application];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[RhodesLib getSharedInstance] applicationDidBecomeActive:application];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[RhodesLib getSharedInstance] applicationWillTerminate:application];
    
}


@end
