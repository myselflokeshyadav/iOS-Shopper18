//
//  Product.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Product.h"

@interface Product ()

@property (readwrite) NSString
    *pid,
    *name,
    *quantity,
    *prize,
    *desc,
    *imageURL;

@end

@implementation Product

+ (instancetype)initWithInfo:(NSDictionary *)info {
    Product *product = Product.new;
    if (product) {
        product.pid = info[@"id"];
        product.name = info[@"pname"];
        product.quantity = info[@"quantity"];
        product.prize = info[@"prize"];
        product.desc = info[@"discription"];
        product.imageURL = info[@"image"];
    }
    return product;
}

@end

