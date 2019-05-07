//
//  ShipmentTrack.h
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShipmentTrack : NSObject

@property (strong, nonatomic, readonly) NSString
    *sid,
    *status;

+ (instancetype)initWithInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
