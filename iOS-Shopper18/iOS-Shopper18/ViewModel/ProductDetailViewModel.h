//
//  ProductDetailViewModel.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "ProductStore.h"
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewModel : NSObject

- (instancetype)initWithProduct:(Product *)product;

- (NSString *)productName;
- (NSString *)showProductName;
- (NSString *)showDescription;

@end

NS_ASSUME_NONNULL_END
