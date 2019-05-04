//
//  RegisterViewModel.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewModel : NSObject

- (void)register:(NSDictionary *)info completion:(void (^)(BOOL success, NSString * _Nullable msg))completion;

@end

NS_ASSUME_NONNULL_END
