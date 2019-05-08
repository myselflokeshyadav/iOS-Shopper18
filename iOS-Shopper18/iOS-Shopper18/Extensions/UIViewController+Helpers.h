//
//  UIViewController+Helpers.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Helpers)

- (void)alert:(NSString*)title msg:(NSString *)msg;
- (void)alert:(NSString*)title msg:(NSString *)msg completion:(void (^)(void))completion;

- (IBAction) signout;

@end

NS_ASSUME_NONNULL_END
