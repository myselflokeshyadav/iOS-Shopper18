//
//  Order.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Order : NSObject

@property (strong, nonatomic, readonly) NSString
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

+ (instancetype)initWithInfo:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END
