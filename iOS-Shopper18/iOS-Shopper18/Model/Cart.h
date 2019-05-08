//
//  Cart.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/6/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;

NS_ASSUME_NONNULL_BEGIN

@interface Cart : NSObject

@property (strong, nonatomic) NSMutableArray<Product *> *items;

+ (instancetype)shared;

- (BOOL)addProduct:(Product *)product;
- (void)removeProduct:(NSUInteger)index;
- (void)setProducts:(NSArray<Product *> *)products;
- (void)loadProducts:(void (^)(BOOL))completion;
- (void)changeProductQuantityAt:(NSInteger)index amount:(NSInteger)amount;
- (void)clearCart:(void (^)(BOOL success, NSError * _Nullable error))completion;
- (void)deleteItems:(NSMutableIndexSet *)indices completion:(void (^)(BOOL success, NSError * _Nullable error))completion;
- (void)saveCart:(void (^)(BOOL))completion;
- (double)totalPrice;

@end

NS_ASSUME_NONNULL_END
