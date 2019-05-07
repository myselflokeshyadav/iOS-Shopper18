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

- (void)clearCart:(void (^)(BOOL success, NSError * _Nullable error))completion {
    [self.items removeAllObjects];
    [FirebaseHandler.shared clearCartForUser:^(NSError * _Nullable error) {
        if (!error) completion(YES, nil);
        else completion(NO, error);
    }];
}

- (void)deleteItems:(NSMutableIndexSet *)indices completion:(void (^)(BOOL success, NSError * _Nullable error))completion {
    dispatch_group_t dg = dispatch_group_create();
    NSArray *products = [self.items objectsAtIndexes:indices];
    [self.items removeObjectsAtIndexes:indices];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [products enumerateObjectsUsingBlock:^(Product *prod, NSUInteger i, BOOL *stop) {
            dispatch_group_enter(dg);
            [FirebaseHandler.shared removeProduct:prod.pid completion:^(NSError * _Nullable error) {
                dispatch_group_leave(dg);
            }];
        }];
        dispatch_group_notify(dg, dispatch_get_main_queue(), ^{
            completion(YES, nil);
        });
    });
}

- (void)saveCart:(void (^)(BOOL))completion {
    [FirebaseHandler.shared saveProducts:self.items completion:^(BOOL success, NSError * _Nullable error) {
        completion(success);
    }];
}

@end
