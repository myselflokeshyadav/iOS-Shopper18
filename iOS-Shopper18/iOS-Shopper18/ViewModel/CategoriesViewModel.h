//
//  CategoriesViewModel.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesViewModel : NSObject

@property(assign,nonatomic) NSMutableArray<Category *>* categories;


@end

NS_ASSUME_NONNULL_END
