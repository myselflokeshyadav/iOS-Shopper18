//
//  OrderFormViewModel.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;

NS_ASSUME_NONNULL_BEGIN

@interface OrderFormViewModel : NSObject

@property (strong, nonnull) NSMutableArray<Product *> *products;

- (void)placeOrder:(NSDictionary *)orderInfo completion:(void (^)(BOOL, NSError * _Nullable))completion;
- (void)postToServer:(NSString *)amount completion:(void (^)(id _Nullable, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
