//
//  ProfileViewModel.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewModel : NSObject

- (void)updateProfile:(NSDictionary *)info completion:(void (^)(id _Nullable, NSError * _Nullable))completion;

- (void)changePassword:(NSDictionary *)info completion:(void (^)(id _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
