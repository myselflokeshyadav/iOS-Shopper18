//
//  TopSeller.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopSeller : NSObject

@property (strong, nonatomic, readonly) NSString
    *sellID,
    *name,
    *deal,
    *rating,
    *logo;

+ (instancetype)initWithInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
