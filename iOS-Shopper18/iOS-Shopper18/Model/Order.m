//
//  Order.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Order.h"

@interface Order ()

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
        
        NSDictionary *statuses = @{ @"1": @"Order confirmed",
                                    @"2": @"Order dispatched",
                                    @"3": @"Order on the way",
                                    @"4": @"Order delivered"
                                   };
        order.status = statuses[info[@"orderstatus"]];
        if (!order.status) order.status = kUnknownOrderStatus;
    }
    return order;
}
@end
