//
//  CategoriesViewModel.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "CategoriesViewModel.h"
#import "APIHandler.h"

@implementation CategoriesViewModel

- (void)getProductCategories:(void(^)(NSError * _Nullable error))completion{
    self.info = NSDictionary.new;
    
    [APIHandler.shared getProductCategories:self.info completion:^(id categoryList, NSError * error) {
        if(error == nil){
            self.categories = categoryList;
            completion(nil);
        }
        else{
            completion(error);
        }
    }];
    
}

@end
