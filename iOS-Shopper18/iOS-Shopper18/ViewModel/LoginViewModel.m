//
//  LoginViewModel.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "LoginViewModel.h"
#import "APIHandler.h"
@implementation LoginViewModel

- (void)login:(NSDictionary *)info completion:(void (^)(BOOL, NSString * _Nullable))completion {
    [APIHandler.shared loginUser:info completion:^(id _Nullable result, NSError * _Nullable error) {
        if (result) completion(YES, nil);
        else completion(NO, @"Mobile number is not registered");
    }];
}

@end
