//
//  Cart.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/6/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Cart.h"
#import "FirebaseHandler.h"

@interface Cart ()

@property (strong, nonatomic) NSMutableDictionary *pids;

@end

@implementation Cart

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = NSMutableArray.new;
        self.pids = NSMutableDictionary.new;
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

- (BOOL)addProduct:(Product *)product {
    if (self.pids[product.pid]) return NO;
    [self.items addObject:[product copy]];
    self.pids[product.pid] = @YES;
    [FirebaseHandler.shared addProduct:product completion:^(NSError * _Nullable error) {
        
    }];
    return YES;
}

- (void)removeProduct:(NSUInteger)index {
    if (index < 0 || index >= self.items.count) return;
    Product *removed = self.items[index];
    [self.pids removeObjectForKey:removed.pid];
    [self.items removeObjectAtIndex:index];
    
    [FirebaseHandler.shared removeProduct:removed.pid completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)setProducts:(NSArray<Product *> *)products {
    self.items = [NSMutableArray arrayWithArray:products];
    [self.pids removeAllObjects];
    for (Product *product in self.items)
        self.pids[product.pid] = @YES;
}

- (void)loadProducts:(void (^)(BOOL))completion {
    [FirebaseHandler.shared cartForUser:^(NSMutableArray * _Nullable results) {
        if (results) {
            self.items = results;
            for (Product *product in self.items)
                self.pids[product.pid] = @YES;
        }
        completion(results);
    }];
}

- (void)changeProductQuantityAt:(NSInteger)index amount:(NSInteger)amount {
    if (index < 0 || index >= self.items.count) return;
    self.items[index].quantity = amount;
    [FirebaseHandler.shared addProduct:self.items[index] completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)deleteItems:(NSMutableIndexSet *)indices completion:(void (^)(BOOL success, NSError * _Nullable error))completion {
    
}

- (void)saveCart:(void (^)(BOOL))completion {
    [FirebaseHandler.shared saveProducts:self.items completion:^(BOOL success, NSError * _Nullable error) {
        completion(success);
    }];
}

@end
