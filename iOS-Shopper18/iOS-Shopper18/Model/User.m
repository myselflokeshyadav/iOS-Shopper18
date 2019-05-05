//
//  User.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)initWithInfo:(NSDictionary *)info {
    User *user = User.new;
    if (user) {
        user.userID = info[@"id"];
        user.fname = info[@"firstname"];
        user.lname = info[@"lastname"];
        user.email = info[@"email"];
        user.mobile = info[@"mobile"];
        user.apiKey = info[@"appapikey "];
    }
    return user;
}

-(NSString *)name {
    return [NSString stringWithFormat:@"%@ %@", self.fname, self.lname];
}

@end
