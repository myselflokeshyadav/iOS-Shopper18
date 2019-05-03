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
        category.cid = [self parseFromKeys:@[@"cid", @"scid"] info:info];
        category.name = [self parseFromKeys:@[@"cname", @"scname"] info:info];
        category.desc = [self parseFromKeys:@[@"cdiscription", @"scdiscription"] info:info];
        
        category.imageURL = [self parseFromKeys:@[@"cimagerl", @"scimageurl"] info:info];
    }
    return category;
}

+ (id) parseFromKeys:(NSArray<NSString *> *)keys info:(NSDictionary *)info {
    for (NSString *key in keys)
        if (info[key]) return info[key];
    return nil;
}

-(NSString *)scid {
    return self.cid;
}

@end
