//
//  ShipmentViewModel.h
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShipmentTrack.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShipmentViewModel : NSObject

@property(strong, nonatomic) ShipmentTrack * shipmentTrack;

-(void)shipment:(NSString *)orderID completionHandler:(void(^)(NSError * _Nullable))completion;
-(NSString *)getShipmentID;

@end

NS_ASSUME_NONNULL_END
