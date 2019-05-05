//
//  User.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong, nonatomic) NSString
    *userID,
    *fname,
    *lname,
    *email,
    *mobile,
    *apiKey;

+ (instancetype)initWithInfo:(NSDictionary *)info;

- (NSString *)name;

@end

NS_ASSUME_NONNULL_END
