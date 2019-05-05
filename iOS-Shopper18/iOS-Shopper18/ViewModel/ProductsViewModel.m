//
//  ProductsViewModel.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProductsViewModel.h"
#import "APIHandler.h"

@implementation ProductsViewModel

- (void)getProducts:(NSString *)cid completion:(void(^)(id _Nullable, NSError * _Nullable))completion{
//    [APIHandler.shared getProductSubCategories:cid completion:^(id productList, NSError * error) {
//        if(error == nil){
//            self.productList = productList;
//            completion(productList,nil);
//        }
//        else{
//            completion(nil,error);
//        }
//    }];
}

@end
