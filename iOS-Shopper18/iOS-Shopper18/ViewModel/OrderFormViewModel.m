//
//  OrderFormViewModel.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "OrderFormViewModel.h"
#import "APIHandler.h"
#import "Cart.h"

@implementation OrderFormViewModel

+ (instancetype)initWithProducts:(NSMutableArray<Product *> *)products {
    OrderFormViewModel *vm = OrderFormViewModel.new;
    if (vm) vm.products = products;
    return vm;
}

- (void)placeOrder:(NSDictionary *)orderInfo completion:(void (^)(BOOL success, NSError * _Nullable))completion {
    [APIHandler.shared placeOrders:orderInfo products:[Cart.shared items] completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        NSMutableIndexSet *indices = [NSMutableIndexSet new];
        NSMutableArray *succeeded = NSMutableArray.new;
        [result enumerateObjectsUsingBlock:^(NSNumber * _Nonnull success, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([success boolValue]) {
                [indices addIndex:idx];
                [succeeded addObject:Cart.shared.items[idx]];
            }
        }];
        if (Cart.shared.items.count == succeeded.count) {
            [Cart.shared clearCart:^(BOOL success, NSError * _Nullable error) {
                completion(YES, nil);
            }];
        }
        else {
            [Cart.shared deleteItems:indices completion:^(BOOL success, NSError * _Nullable error) {
                completion(NO, nil);
            }];
        }
    }];
}

- (void)postToServer:(NSString *)amount completion:(void (^)(id _Nullable, NSError *))completion {
    // Update URL with your server
    NSURL *paymentURL = [NSURL URLWithString:@"http://127.0.0.1:3000/payment"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:paymentURL];
    request.HTTPBody = [[NSString stringWithFormat:@"amount=%@", amount] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle success and failure
        completion(data, error);
        NSLog(@"Post request success!!");
    }] resume];
}

@end
