//
//  FirebaseHandler.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "FirebaseHandler.h"

@interface FirebaseHandler ()
+ (instancetype)shared;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRDatabaseReference *cartRef;

@end


@implementation FirebaseHandler


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ref = [[FIRDatabase database] reference];
        self.cartRef = [self.ref child:@"Carts"];
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

- (void)addProduct:(Product *)pInfo completion:(void(^)(NSError * _Nullable))completion {
    NSString *pid = [NSString stringWithFormat:@"pid%@", pInfo.pid];
    [[[self.cartRef child:APIHandler.shared.userID] child:pid]
     setValue:pInfo.encodeJSON];
}

- (void)removeProduct:(NSString *)pid completion:(void(^)(NSError * _Nullable))completion {
    pid = [NSString stringWithFormat:@"pid%@", pid];
    [[[self.cartRef child:APIHandler.shared.userID] child:pid] removeValue];
}

-  (void)cartForUser:(void(^)(NSMutableArray * _Nullable))completion {
    [[self.cartRef child:APIHandler.shared.userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        
        NSDictionary *cartList = snapshot.value;
        
        NSMutableArray<Product *> *items = NSMutableArray.new;
        if ([cartList isKindOfClass:[NSNull class]]) {
            completion(items);
            return;
        }
        for (NSString *pid in cartList) {
            NSDictionary *info = cartList[pid];
            Product *product = [Product loadFromInfo:info];
            [items addObject:product];
        }
        completion(items);
    }];
}

- (void)clearCartForUser:(void(^)(NSError * _Nullable))completion {
    [[self.cartRef child:APIHandler.shared.userID] removeValueWithCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error);
    }];
}

- (void)saveProducts:(NSArray<Product *> *)products completion:(void (^)(BOOL, NSError * _Nullable ))completion {
    dispatch_group_t dg = dispatch_group_create();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [products enumerateObjectsUsingBlock:^(Product *prod, NSUInteger i, BOOL *stop) {
            dispatch_group_enter(dg);
            [self addProduct:prod completion:^(NSError * _Nullable error) {
                dispatch_group_leave(dg);
            }];
        }];
        dispatch_group_notify(dg, dispatch_get_main_queue(), ^{
            completion(YES, nil);
        });
    });
}

@end
