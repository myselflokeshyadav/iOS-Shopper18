//
//  APIHandler.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "APIHandler.h"
#import "APIParser.h"

@interface APIHandler ()

@property (strong, nonatomic, nullable) NSString *apiKey;
@property (strong, nonatomic, nullable) NSString *userID;

@end

@implementation APIHandler

+ (instancetype)shared {
    static dispatch_once_t pred = 0;
    static id _shared = nil;
    dispatch_once(&pred, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiKey = kTestAPIKey;
        self.userID = kTestUserID;
    }
    return self;
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
             completion: (void(^)(id _Nullable, NSError * _Nullable))completion {
    
    NSURL *url = [NSURL URLWithString:[self constructURL:base endpoint:endpoint params:params]];
    [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable _, NSError * _Nullable error) {
        if (data) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
            if (!result) result = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
            completion(result, error);
        } else completion(nil, error);
    }].resume;
}

- (NSDictionary *)extendedInfo:(NSDictionary *)info {
    NSMutableDictionary *newInfo = [NSMutableDictionary dictionaryWithDictionary:info];
    newInfo[@"api_key"] = self.apiKey;
    newInfo[@"user_id"] = self.userID;
    return newInfo;
}

- (void)registerUser:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointRegister params:info completion:completion];
    
}

- (void)loginUser:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointLogin params:info completion:completion];
    
}

- (void)updateProfile:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointProfile params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        
    }];
    
}


- (void)resetPassword:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointPassw params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        
    }];
    
}

- (void)forgotPassword:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointForgot params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        
    }];
    
}

- (void)getProductCategories:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointCategory params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        if (result) completion([APIParser categoriesFrom:result], nil);
        else completion(nil, error);
    }];
    
}

- (void)getProductSubCategories:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointSubCategory params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        if (result) completion([APIParser categoriesFrom:result], nil);
        else completion(nil, error);
    }];
    
}

- (void)getProducts:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPICartBase endpoint:kAPIEndPointProductList params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        if (result) completion([APIParser productsFrom:result], nil);
        else completion(nil, error);
    }];
    
}

- (void)placeOrder:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointMakeOrder params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        if (result) completion([APIParser ordersFrom:result], nil);
        else completion(nil, error);
    }];
    
}

- (void)getOrderHistory:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointOrderHist params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        if (result) completion([APIParser ordersFrom:result], nil);
        else completion(nil, error);
    }];
    
}

- (void)getShipmentTrack:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointShipTrack params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        
    }];
    
}

- (void)getCoupon:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    info = [self extendedInfo:info];
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointCoupon params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        
    }];
    
}

- (void)uploadProfilePic:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    [self callAPIWithBase:kAPIEcomBase endpoint:kAPIEndPointCoupon params:info completion:^(id _Nullable result, NSError * _Nullable error ) {
        
    }];
    
}
@end
