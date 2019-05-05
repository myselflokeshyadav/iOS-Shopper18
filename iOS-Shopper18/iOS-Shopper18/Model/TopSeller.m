//
//  TopSeller.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "TopSeller.h"

@interface TopSeller ()

@property (readwrite) NSString
    *sellID,
    *name,
    *deal,
    *rating,
    *logo;

@end

@implementation TopSeller

+ (instancetype)initWithInfo:(NSDictionary *)info {
    TopSeller *topSeller = TopSeller.new;
    if (topSeller) {
        topSeller.sellID = info[@"id"];
        topSeller.name = info[@"sellername"];
        topSeller.deal = info[@"sellerdeal"];
        topSeller.rating = info[@"sellerrating"];
        topSeller.logo = info[@"sellerlogo"];
    }
    return topSeller;
}

@end
