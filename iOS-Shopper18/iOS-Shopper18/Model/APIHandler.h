//
//  APIHandler.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIHandler : NSObject

@property (strong, nonnull) NSString *apiKey;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
