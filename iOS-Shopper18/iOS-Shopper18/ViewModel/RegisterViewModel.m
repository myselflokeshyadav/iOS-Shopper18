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
            if ([msg containsString:@"success"]) completion(YES, nil);
            else completion(NO, msg);
        }
    }];
}

@end
