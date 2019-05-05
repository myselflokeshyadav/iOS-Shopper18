//
//  SubcategoriesViewModel.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubcategoriesViewModel : NSObject

@property(assign,nonatomic) NSMutableArray<Category *>* subcategories;


- (void)getProductSubCategories:(NSString *)cid completion:(void(^)(id _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
