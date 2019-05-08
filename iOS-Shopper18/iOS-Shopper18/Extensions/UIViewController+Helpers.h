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
- (IBAction) signout;

@end

NS_ASSUME_NONNULL_END
