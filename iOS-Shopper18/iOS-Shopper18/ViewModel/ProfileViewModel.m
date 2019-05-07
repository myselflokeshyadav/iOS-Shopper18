//
//  ProfileViewModel.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProfileViewModel.h"
#import "APIHandler.h"
#import "User.h"

@implementation ProfileViewModel

- (void)updateProfile:(NSDictionary *)info completion:(void (^)(id _Nullable, NSError * _Nullable))completion {
    
    [APIHandler.shared updateProfile:info completion:^(id _Nullable result, NSError * _Nullable error) {
        if (result) [APIHandler.shared.currentUser update:info];
        completion(result, error);
    }];
}

- (void)changePassword:(NSDictionary *)info completion:(void (^)(id _Nullable, NSError * _Nullable))completion {
    [APIHandler.shared changePassword:info completion:completion];
}

@end
