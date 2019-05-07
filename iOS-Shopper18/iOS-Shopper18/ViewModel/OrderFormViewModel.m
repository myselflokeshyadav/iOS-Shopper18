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

+ (instancetype)initWithProducts:(NSMutableArray<Product *> *)products {
    OrderFormViewModel *vm = OrderFormViewModel.new;
    if (vm) vm.products = products;
    return vm;
}

- (void)placeOrder:(NSDictionary *)orderInfo completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion {
    [APIHandler.shared placeOrders:orderInfo products:self.products completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        NSMutableIndexSet *indices = [NSMutableIndexSet new];
        NSMutableArray *succeeded = NSMutableArray.new;
        [result enumerateObjectsUsingBlock:^(NSNumber * _Nonnull success, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([success boolValue]) {
                [indices addIndex:idx];
                [succeeded addObject:self.products[idx]];
            }
        }];
        [self.products removeObjectsAtIndexes:succeeded];
        
    }];
}

@end
