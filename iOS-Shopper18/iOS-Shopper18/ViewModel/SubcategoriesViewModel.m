//
//  SubcategoriesViewModel.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "SubcategoriesViewModel.h"
#import "APIHandler.h"

@implementation SubcategoriesViewModel

- (void)getProductSubCategories:(NSString *)cid completion:(void(^)(id _Nullable, NSError * _Nullable))completion{
    [APIHandler.shared getProductSubCategories:cid completion:^(id subcategoryList, NSError * error) {
        if(error == nil){
            self.subcategories = subcategoryList;
            completion(subcategoryList,nil);
        }
        else{
            completion(nil,error);
        }
    }];
}

@end
