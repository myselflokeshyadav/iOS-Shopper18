//
//  Category.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "Category.h"

@interface Category ()

@property (readwrite) NSString
    *cid,
    *name,
    *desc,
    *imageURL;

@end

@implementation Category

+ (instancetype)initWithInfo:(NSDictionary *)info {
    Category *category = [self init];
    if (category) {
        category.cid = info[@"cid"];
        category.name = info[@"cname"];
        category.desc = info[@"cdiscription"];
        category.imageURL = info[@"cimagerl"];
    }
    return category;
}

@end
