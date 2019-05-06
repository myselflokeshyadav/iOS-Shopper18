//
//  FirebaseHandler.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "APIHandler.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface FirebaseHandler : NSObject
+ (instancetype)shared;
- (void)addProduct:(Product *)pInfo completion:(void(^)(NSError * _Nullable))completion;
- (void)removeProduct:(NSString *)pid completion:(void(^)(NSError * _Nullable))completion;
- (void)cartForUser:(void(^)(NSMutableArray * _Nullable))completion;
- (void)clearCartForUser:(void(^)(NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
