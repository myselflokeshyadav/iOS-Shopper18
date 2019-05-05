//
//  ProductsViewModel.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductsViewModel : NSObject

@property(strong, nonnull) NSString *cid;
//@property(strong, nonnull) NSString *scid;
@property(assign,nonatomic) NSMutableArray<Product *>* productList;

- (void)getProducts:(NSString *)cid scid:(NSString *)scid completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
