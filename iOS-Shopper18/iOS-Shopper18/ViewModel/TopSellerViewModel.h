//
//  TopSellerViewModel.h
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TopSeller;

NS_ASSUME_NONNULL_BEGIN

@interface TopSellerViewModel : NSObject
@property (strong, nonatomic) NSArray<TopSeller *> *topSellers;

- (void)getTopSellers:(void (^)(BOOL success, NSString * _Nullable error))completion;
- (nullable TopSeller *)topSellerAt:(NSInteger)index;
- (NSInteger)numTopSellers;

@end

NS_ASSUME_NONNULL_END
