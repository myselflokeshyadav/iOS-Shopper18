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
    [APIHandler.shared getProductSubCategories:cid completion:^(id categoryList, NSError * error) {
        if(error == nil){
            self.subcategories = categoryList;
            completion(categoryList,nil);
        }
        else{
            completion(nil,error);
        }
    }];
}
//- (void)getProductSubcategories:(void(^)(NSError * _Nullable error))completion{
//    self.info = NSDictionary.new;
//
//    [APIHandler.shared getProductCategories:self.info completion:^(id categoryList, NSError * error) {
//        if(error == nil){
//            self.subcategories = categoryList;
//            completion(nil);
//        }
//        else{
//            completion(error);
//        }
//    }];
//}

@end
