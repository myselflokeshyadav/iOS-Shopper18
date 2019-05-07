//
//  APIParser.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;
@class Category;
@class Order;
@class User;
@class TopSeller;
@class ShipmentTrack;

NS_ASSUME_NONNULL_BEGIN

@interface APIParser : NSObject

+ (nullable NSArray<Category *> *)categoriesFrom:(id)jsonObject;
+ (nullable NSArray<Product *> *)productsFrom:(id)jsonObject;
+ (nullable Order *)orderFrom:(id)jsonObject;
+ (nullable NSArray<Order *> *)orderHistoryFrom:(id)jsonObject;
+ (nullable User *)userFrom:(id)jsonObject;
+ (nullable NSArray<TopSeller *> *)topSellersFrom:(id)jsonObject;
+ (nullable ShipmentTrack *)shipmentFrom:(id)jsonObject;

@end

NS_ASSUME_NONNULL_END
