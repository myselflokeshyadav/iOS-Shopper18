//
//  TopSellerViewModel.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "TopSellerViewModel.h"
#import "APIHandler.h"
@implementation TopSellerViewModel

- (void)getTopSellers:(void (^)(BOOL, NSString * _Nullable))completion {
    [APIHandler.shared getTopSellers:^(id _Nullable result, NSError * _Nullable error) {
        if (result) {
            self.topSellers = result;
            completion(YES, nil);
        } else completion(NO, @"Server error. Please try again later.");
    }];
}

- (nullable TopSeller *)topSellerAt:(NSInteger)index {
    if (!self.topSellers) return nil;
    return self.topSellers[index];
}

- (NSInteger)numTopSellers {
    if (!self.topSellers) return 0;
    return self.topSellers.count;
}

@end
