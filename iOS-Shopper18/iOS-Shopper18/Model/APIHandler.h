//
//  APIHandler.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIHandler : NSObject

+ (instancetype)shared;

- (void)registerUser:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)loginUser:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)updateProfile:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)resetPassword:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)forgotPassword:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getProductCategories:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getProductSubCategories:(NSString *)cid completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getProductsWithCid:(NSString *)cid scid:(NSString *)scid completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)placeOrder:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getOrderHistory:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getShipmentTrack:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getCoupon:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)uploadProfilePic:(NSDictionary *)info completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

- (void)getTopSellers:(void(^)(id _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
