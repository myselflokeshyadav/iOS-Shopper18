//
//  Product.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Product : NSObject

@property (strong, nonatomic) NSString
    *pid,
    *name,
    *desc,
    *imageURL;

@property (assign, nonatomic) NSInteger quantity;
@property (assign, nonatomic) double price;

+ (instancetype)initWithInfo:(NSDictionary *)info;

+ (instancetype)initWithID:(NSString *)pid name:(NSString *)name price:(double)price;

+ (instancetype)initWithID:(NSString *)pid name:(NSString *)name price:(double)price quantity:(NSInteger)count;

- (double) totalPrice;

- (NSDictionary *)orderInfo;

@end

NS_ASSUME_NONNULL_END
