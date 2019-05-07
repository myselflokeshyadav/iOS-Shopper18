//
//  AppDelegate.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "AppDelegate.h"
#import "BraintreeCore.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBar.appearance.tintColor = UIColor.whiteColor;
    UITabBar.appearance.barTintColor = kColorPrimeGreen;
    UINavigationBar.appearance.barTintColor = kColorPrimeGreen;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    
    [BTAppSwitch setReturnURLScheme:@"com.iOSDevs.iOS-Shopper18.payments"];
    [FIRApp configure];
    
    
//    NSString *starting = @"HomeTab";
    
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier: starting];
//
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme localizedCaseInsensitiveCompare:@"com.iOSDevs.iOS-Shopper18.payments"] == NSOrderedSame) {
        return [BTAppSwitch handleOpenURL:url options:options];
    }
    return NO;
}


@end
