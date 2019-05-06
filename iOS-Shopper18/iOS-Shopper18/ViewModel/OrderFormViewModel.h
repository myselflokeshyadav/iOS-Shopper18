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

@property (strong, nonnull) NSArray<Product *> *products;

- (void)placeOrder:(NSDictionary *)orderInfo completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
