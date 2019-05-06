//
//  ShipmentViewModel.m
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ShipmentViewModel.h"
#import "APIHandler.h"


@implementation ShipmentViewModel

-(void)getShipmenTrack:(NSString *)orderID completionHandler:(void (^)(NSError * _Nullable))completion{
    NSMutableDictionary *newInfo = NSMutableDictionary.new;
    [newInfo setValue:orderID forKey:@"order_id"];
    NSLog(@"before I call getshipment with info %@",newInfo);;
    [APIHandler.shared getShipmentTrack:newInfo completion:^(id shipmentTrackObj, NSError * error){
        if(error == nil){
            ShipmentTrack *newShipmentTrack = [ShipmentTrack initWithInfo:shipmentTrackObj];
            
            self.shipmentTrack = newShipmentTrack;
            completion(nil);
        }else{
            completion(error);
        }
    }];
}
-(NSString *)getShipmentID{
    return self.shipmentTrack.sid;
}

-(NSString *)getShipmentStatus{
    NSString *status = self.shipmentTrack.status;
    if([status  isEqual: @"1"]){
        return @"Order Confirm";
    }else if([status  isEqual: @"2"]){
        return @"Order Dispatch";
    }else if([status  isEqual: @"3"]){
        return @"Order On the Way";
    }else if([status  isEqual: @"4"]){
        return @"Order Delievered";
    }
    return @"ERROR ";
}

/*
 If Received results as " shipmentstatus ":"1" Its means Order Confirm
 If Received results as " shipmentstatus ":"2" Its means Order Dispatch
 If Received results as " shipmentstatus ":"3" Its means Order On the Way
 If Received results as " shipmentstatus ":"4" Its means Order Delivered
 */



@end

