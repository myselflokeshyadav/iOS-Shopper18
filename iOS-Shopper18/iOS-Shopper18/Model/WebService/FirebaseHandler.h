//
//  FirebaseHandler.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface FirebaseHandler : NSObject
+ (instancetype)shared;
@property (strong, nonatomic) FIRDatabaseReference *ref;

- (void)addProductToFirebase:(Product *)pInfo completion:(void(^)(id _Nullable, NSError * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
