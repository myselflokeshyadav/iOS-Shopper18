//
//  LoginViewModel.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

- (void)login:(NSDictionary *)info completion:(void (^)(BOOL success, NSString * _Nullable msg))completion;

@end

NS_ASSUME_NONNULL_END
