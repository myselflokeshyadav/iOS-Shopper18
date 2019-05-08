//
//  UIViewController+Helpers.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "UIViewController+Helpers.h"
#import "AppDelegate.h"
#import <SVProgressHUD.h>
@implementation UIViewController (Helpers)

- (void)alert:(NSString*)title msg:(NSString *)msg {
    [self alert:title msg:msg completion:nil];
}

- (void)alert:(NSString*)title msg:(NSString *)msg completion:(void (^)(void))completion {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:completion];
}

- (void)signout {
    [SVProgressHUD show];
    [NSUserDefaults.standardUserDefaults removeObjectForKey:kUserDefaultsUserInfo];
    [NSUserDefaults.standardUserDefaults synchronize];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier: kLoginVCID];
    id<UIApplicationDelegate> app = UIApplication.sharedApplication.delegate;
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [SVProgressHUD dismiss];
        app.window.rootViewController = viewController;
    });
    
    
}

@end
