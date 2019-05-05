//
//  APIParser.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "APIParser.h"
#import "Category.h"
#import "Product.h"
#import "Order.h"
#import "User.h"

@implementation APIParser

+ (nullable NSArray<Category *> *)categoriesFrom:(id)jsonObject {
    NSDictionary *dict = jsonObject;
    
    NSArray *categories = (dict[@"category"])? dict[@"category"] : dict[@"subcategory"];
    NSMutableArray *list = NSMutableArray.new;
    for (NSDictionary *info in categories)
        [list addObject:[Category initWithInfo:info]];
    return list;
}

+ (nullable NSArray<Product *> *)productsFrom:(id)jsonObject {
    NSArray *products = ((NSDictionary *)jsonObject)[@"products"];
    NSMutableArray *list = NSMutableArray.new;
    for (NSDictionary *info in products)
        [list addObject:[Product initWithInfo:info]];
    return list;
}


+ (nullable NSArray<Order *> *)ordersFrom:(id)jsonObject {
    NSDictionary *dict = jsonObject;
    NSArray *orders = (dict[@"Order confirmed"])? dict[@"Order confirmed"] : dict[@"Order history"];
    NSMutableArray *list = NSMutableArray.new;
    for (NSDictionary *info in orders)
        [list addObject:[Order initWithInfo:info]];
    return list;
}

+ (nullable User *)userFrom:(id)jsonObject {
    if ([jsonObject isKindOfClass:NSDictionary.class]) return nil;
    if (![jsonObject isKindOfClass:NSArray.class]) return nil;
    NSDictionary *info = jsonObject[0];
    return [User initWithInfo:info];
}

@end
