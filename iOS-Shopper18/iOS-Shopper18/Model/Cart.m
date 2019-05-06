//
//  Cart.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/6/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Cart.h"
#import "FirebaseHandler.h"

@implementation Cart

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = NSMutableArray.new;
    }
    return self;
}

+ (instancetype)shared {
    static dispatch_once_t pred = 0;
    static id _shared = nil;
    dispatch_once(&pred, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)addProduct:(Product *)product {
    [self.items addObject:product];
    [FirebaseHandler.shared addProduct:product completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)removeProduct:(NSUInteger)index {
    if (index < 0 || index >= self.items.count) return;
    Product *removed = self.items[index];
    [self.items removeObjectAtIndex:index];
    
    [FirebaseHandler.shared removeProduct:removed.pid completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)setProducts:(NSArray<Product *> *)products {
    self.items = [NSMutableArray arrayWithArray:products];
}

- (void)loadProducts:(void (^)(BOOL))completion {
    [FirebaseHandler.shared cartForUser:^(NSMutableArray * _Nullable results) {
        if (results) self.items = results;
        completion(results);
    }];
}

@end
