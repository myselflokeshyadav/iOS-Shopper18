//
//  Order.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Order.h"

@interface Order ()

@property (readwrite) NSString
    *orderID,
    *status,
    *name,
    *billAddr,
    *deliverAddr,
    *mobile,
    *email,
    *itemID,
    *itemName,
    *quantity,
    *totalPrice,
    *paidPrice,
    *datePlaced;
@end

@implementation Order

+ (instancetype)initWithInfo:(NSDictionary *)info {
    Order *order = Order.new;
    if (order) {
        order.orderID = info[@"orderid"];
        order.status = info[@"orderstatus"];
        order.name = info[@"name"];
        order.billAddr = info[@"billingadd"];
        order.deliverAddr = info[@"deliveryadd"];
        order.mobile = info[@"mobile"];
        order.email = info[@"email"];
        order.itemID = info[@"itemid"];
        order.itemName = info[@"itemname"];
        order.quantity = info[@"itemquantity"];
        order.totalPrice = info[@"totalprice"];
        order.paidPrice = info[@"paidprice"];
        order.datePlaced = info[@"placedon"];
    }
    return order;
}

@end
