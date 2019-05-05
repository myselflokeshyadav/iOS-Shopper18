//
//  Product.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Product.h"

@interface Product ()

@end

@implementation Product

+ (instancetype)initWithInfo:(NSDictionary *)info {
    Product *product = Product.new;
    if (product) {
        product.pid = info[@"id"];
        product.name = info[@"pname"];
        product.quantity = 1;
        product.price = [info[@"prize"] doubleValue];
        product.desc = info[@"discription"];
        product.imageURL = info[@"image"];
    }
    return product;
}

+ (instancetype)initWithID:(NSString *)pid name:(NSString *)name price:(double)price {
    Product *product = Product.new;
    if (product) {
        product.pid = pid;
        product.name = name;
        product.price = price;
        product.quantity = 1;
    }
    return product;
}

+ (instancetype)initWithID:(NSString *)pid name:(NSString *)name price:(double)price quantity:(NSInteger)count {
    Product *product = [Product initWithID:pid name:name price:price];
    if (product) {
        product.quantity = count;
    }
    return product;
}

- (double)totalPrice {
    return self.quantity * self.price;
}

- (NSDictionary *)orderInfo {
    return @{ @"item_id": self.pid,
              @"item_names": self.name,
              @"item_quantity": [NSNumber numberWithInteger:self.quantity],
              @"final_price": [NSNumber numberWithDouble:self.totalPrice]
             };
}

@end

