//
//  UIViewController+Helpers.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "UIViewController+Helpers.h"
#import "AppDelegate.h"
@implementation UIViewController (Helpers)

- (void)alert:(NSString*)title msg:(NSString *)msg {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)signout {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:kUserDefaultsUserInfo];
    [NSUserDefaults.standardUserDefaults synchronize];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier: kLoginVCID];
    id<UIApplicationDelegate> app = UIApplication.sharedApplication.delegate;
    app.window.rootViewController = viewController;
}

@end
