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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Cart.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Facebook stuff
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    //UI AppDel
    UITabBar.appearance.tintColor = UIColor.whiteColor;
    UITabBar.appearance.barTintColor = kColorPrimeGreen;
    UITabBar.appearance.unselectedItemTintColor = kColorSecondaryGreen;
    [UITabBarItem.appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    UINavigationBar.appearance.barTintColor = kColorPrimeGreen;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    [UINavigationBar.appearance setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [BTAppSwitch setReturnURLScheme:kURLScheme];
    [FIRApp configure];
    
    NSUserDefaults *udefs = NSUserDefaults.standardUserDefaults;
    NSDictionary *userInfo = [udefs dictionaryForKey:kUserDefaultsUserInfo];
    User *user;
    if (!userInfo || !(user = [User initWithInfo:userInfo])) return YES;
    APIHandler.shared.currentUser = user;
    [Cart.shared loadProducts:^(BOOL success) {
        if (!success || !Cart.shared.items.count) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.window.rootViewController) {
                if (![self.window.rootViewController isKindOfClass:UITabBarController.class]) return;
                UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
                tabController.tabBar.items[1].badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)Cart.shared.items.count];
            }
        });

        
    }];
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
    if ([url.scheme localizedCaseInsensitiveCompare:kURLScheme] == NSOrderedSame) {
        return [BTAppSwitch handleOpenURL:url options:options];
    }
    //starting facebook handled code
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    return handled;
//delete from facebook code//    return NO;
}
//facebook log, testing if this is activated
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    
    
}
@end
