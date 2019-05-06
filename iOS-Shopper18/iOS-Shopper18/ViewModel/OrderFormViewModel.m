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

+ (instancetype)initWithProducts:(NSArray<Product *> *)products {
    OrderFormViewModel *vm = OrderFormViewModel.new;
    if (vm) vm.products = products;
    return vm;
}

- (void)placeOrder:(NSDictionary *)orderInfo completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion {
    [APIHandler.shared placeOrders:orderInfo products:self.products completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        for (NSNumber *success in result) {
            if ([success boolValue]) {
                
            }
        }
    }];
}

@end
