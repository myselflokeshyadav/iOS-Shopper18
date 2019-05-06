//
//  Cart.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/6/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Cart.h"

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
    //delete this after testing
    NSLog(@"success in adding product");

}

- (void)removeProduct:(NSUInteger)index {
    if (index < 0 || index >= self.items.count) return;
    [self.items removeObjectAtIndex:index];
}

- (void)setProducts:(NSArray<Product *> *)products {
    self.items = [NSMutableArray arrayWithArray:products];
}

- (void)loadProducts {
    
}

@end
