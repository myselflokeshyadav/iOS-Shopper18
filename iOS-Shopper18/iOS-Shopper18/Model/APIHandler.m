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

- (NSString *)constructURL:(NSString *)base endpoint:(NSString *)endpoint params:(NSDictionary *)params {
    base = [base stringByAppendingString:endpoint];
    NSMutableArray *paramList = NSMutableArray.new;
    for (NSString *key in params) {
        [paramList addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    NSString *combinedParams = [paramList componentsJoinedByString:@"&"];
    return [base stringByAppendingString:combinedParams];
}

- (void)callAPIWithBase:(NSString *)base endpoint:(NSString *)endpoint params:(NSDictionary *)params
     completion: (void(^)(NSData * _Nullable, NSError * _Nullable))completion {
    
    NSURL *url = [NSURL URLWithString:[self constructURL:base endpoint:endpoint params:params]];
    [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable _, NSError * _Nullable error) {
        completion(data, error);
    }];
}

- (void)registerUser:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointRegister params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)loginUser:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointLogin params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)updateProfile:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointProfile params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}


- (void)resetPassword:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointPassw params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)forgotPassword:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointForgot params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}


- (void)getProductCategories:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointCategory params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)getProductSubCategories:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointSubCategory params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)placeOrder:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointProductList params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)getOrderHistory:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointProductList params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)getShipmentTrack:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointProductList params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)getCoupon:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointProductList params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}

- (void)uploadProfilePic:(NSDictionary *)info completion:(void(^)(NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointProductList params:info completion:^(NSData * _Nullable data, NSError * _Nullable error ) {
        
    }];
    
}
@end
