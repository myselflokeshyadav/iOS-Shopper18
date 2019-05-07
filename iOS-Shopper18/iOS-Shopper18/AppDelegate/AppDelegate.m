//
//  AppDelegate.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "AppDelegate.h"
#import "BraintreeCore.h"
#import "APIHandler.h"
#import "User.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBar.appearance.tintColor = UIColor.whiteColor;
    UITabBar.appearance.barTintColor = kColorPrimeGreen;
    UITabBar.appearance.unselectedItemTintColor = kColorSecondaryGreen;
    [UITabBarItem.appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    UINavigationBar.appearance.barTintColor = kColorPrimeGreen;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    [UINavigationBar.appearance setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [BTAppSwitch setReturnURLScheme:@"com.iOSDevs.iOS-Shopper18.payments"];
    [FIRApp configure];
    
    NSUserDefaults *udefs = NSUserDefaults.standardUserDefaults;
    NSDictionary *userInfo = [udefs dictionaryForKey:kUserDefaultsUserInfo];
    User *user;
    if (!userInfo || !(user = [User initWithInfo:userInfo])) return YES;
    APIHandler.shared.currentUser = user;
    
    NSString *starting = @"HomeTab";
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier: starting];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
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

//- (void)configure


@end
