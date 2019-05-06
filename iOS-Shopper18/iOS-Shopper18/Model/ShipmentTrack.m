//
//  ShipmentTrack.m
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ShipmentTrack.h"
@interface ShipmentTrack ()

@property (readwrite) NSString
    *sid,
    *status;
@end

@implementation ShipmentTrack
+ (instancetype)initWithInfo:(NSDictionary *)info{
    ShipmentTrack *shipment = ShipmentTrack.new;
    if(shipment){
        shipment.sid = info[@"shipmentid"];
        NSDictionary *statuses = @{ @"1": @"Order confirmed",
                                    @"2": @"Order dispatched",
                                    @"3": @"Order on the way",
                                    @"4": @"Order delivered"
                                    };
        shipment.status = statuses[info[@"shipmentstatus"]];
        if (!shipment.status) shipment.status = kUnknownOrderStatus;
    }
    
    return shipment;
}

@end
