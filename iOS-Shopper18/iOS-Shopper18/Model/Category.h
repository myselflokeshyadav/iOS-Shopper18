//
//  Category.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Category : NSObject

@property (strong, nonatomic, readonly) NSString
    *cid,
    *name,
    *desc,
    *imageURL;

@end

typedef Category Subcategory;

NS_ASSUME_NONNULL_END
