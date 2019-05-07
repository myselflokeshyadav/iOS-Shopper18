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

+ (instancetype)loadFromInfo:(NSDictionary *)info {
    Product *product = [Product initWithInfo:info];
    if (product) {
        product.quantity = [info[@"quantity"] integerValue];
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

- (NSDictionary *)encodeJSON {
    return @{ @"id": self.pid,
              @"pname": self.name,
              @"quantity": [NSNumber numberWithInteger:self.quantity],
              @"prize": [NSNumber numberWithDouble:self.price],
              @"discription": self.desc,
              @"image": self.imageURL
              };
}


- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Product* product = [[Product allocWithZone:zone]init];
    if (product) {
        product.pid = [self.pid copy];
        product.name = [self.name copy];
        product.quantity = self.quantity;
        product.price = self.price;
        product.desc = [self.desc copy];
        product.imageURL = [self.imageURL copy];
    }
    return product;
}

@end

