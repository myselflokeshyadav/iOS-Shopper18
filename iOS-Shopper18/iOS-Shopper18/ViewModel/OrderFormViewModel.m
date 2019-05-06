//
//  OrderFormViewModel.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "OrderFormViewModel.h"
#import "APIHandler.h"

@implementation OrderFormViewModel

- (void)placeOrder:(NSDictionary *)orderInfo completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion {
    [APIHandler.shared placeOrders:orderInfo products:@[] completion:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}

@end
