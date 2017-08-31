//
//  AppDelegate.m
//  FTAE Reports
//
//  Created by Patrick McDonagh on 12/6/12.
//  Copyright (c) 2012 Patrick McDonagh. All rights reserved.
//

#import "AppDelegate.h"
#import "AlarmTableViewController.h"
#import "Last24ViewController.h"
#import "OverrideViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    AlarmTableViewController *alarmTableViewController = [[AlarmTableViewController alloc] init];
    Last24ViewController    *last24ViewController = [[Last24ViewController alloc] init];
    OverrideViewController *overrideViewController = [[OverrideViewController alloc] init];
    
    
    UINavigationController *alarmNavController = [[UINavigationController alloc] initWithRootViewController:alarmTableViewController];
    UINavigationController *last24NavController = [[UINavigationController alloc] initWithRootViewController:last24ViewController];
    UINavigationController *overrideNavController = [[UINavigationController alloc] initWithRootViewController:overrideViewController];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [tabBarController setViewControllers:@[alarmNavController, last24NavController, overrideNavController]];
    self.window.rootViewController = tabBarController;
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
