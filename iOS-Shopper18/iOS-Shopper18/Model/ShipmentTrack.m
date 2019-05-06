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
*shipmentid,
*shipmentstatus;
@end

@implementation ShipmentTrack
+(instancetype)initWithInfo:(NSDictionary *)info{
    NSLog(@"this is info: %@", info);
    ShipmentTrack *shipmentTrack = [[ShipmentTrack alloc] init];
    if(shipmentTrack){
        shipmentTrack.shipmentid = [info valueForKey:@"shipmentid"];
        shipmentTrack.shipmentstatus = [info valueForKey:@"shipmentstatus"];
    }
    return shipmentTrack;
}

@end
