//
//  RegisterViewModel.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "RegisterViewModel.h"
#import "APIHandler.h"

@implementation RegisterViewModel

- (void)register:(NSDictionary *)info completion:(void (^)(BOOL, NSString * _Nullable))completion {
    [APIHandler.shared registerUser:info completion:^(id _Nullable result, NSError * _Nullable error) {
        if (result) {
            NSString *msg = (NSString *)result;
            if ([msg containsString:@"success"]) {
                NSDictionary *loginInfo = @{@"mobile": info[@"mobile"], @"password": info[@"password"]};
                [APIHandler.shared loginUser:loginInfo completion:^(id _Nullable result, NSError * _Nullable error) {
                    if (error) completion(NO, @"Server error, please try again later");
                    else if (result) completion(YES, nil);
                    else completion(NO, @"Error signing in.");
                }];
            }
            else completion(NO, msg);
        } else completion(NO, @"Server error, please try again later");
    }];
}
@end
