//
//  APIHandler.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "APIHandler.h"

@implementation APIHandler

+ (instancetype)shared {
    static dispatch_once_t pred = 0;
    static id _shared = nil;
    dispatch_once(&pred, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (NSString *)constructURL:(NSString *)base params:(NSDictionary *)params {
    NSString *result = [NSMutableString.alloc initWithString:base];
    for (NSString *key in params) {
        
    }
    return @"";
}

- (void)registerUser:(NSDictionary *)userInfo completion:(void(^)(NSError * _Nullable))completion {
    if (!self.apiKey) {
        completion(nil);
        return;
    }
    
    
}

@end
