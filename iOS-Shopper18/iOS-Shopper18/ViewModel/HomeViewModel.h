//
//  HomeViewModel.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopSeller.h"
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

@property (strong, nonatomic) NSMutableArray <Category *> * categories;
@property (strong, nonatomic) NSMutableArray <TopSeller *> * topSellers;

- (void)getTopSellers:(void (^)(BOOL success, NSString * _Nullable error))completion;
- (nullable TopSeller *)topSellerAt:(NSInteger)index;
- (NSInteger)numTopSellers;

- (void)getProductCategories:(void(^)(NSError * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
