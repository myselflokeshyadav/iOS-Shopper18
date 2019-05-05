//
//  SubcategoriesViewController.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "SubcategoriesViewController.h"
#import "CategoryViewCell.h"

@interface SubcategoriesViewController ()

@end

@implementation SubcategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subcategories = NSMutableArray.new;
    self.subcategoryModel = SubcategoriesViewModel.new;
//    [self getProductSubCategories:self.category.cid];
    [self getProductSubCategories:@"108"];
}

- (void)getProductSubCategories:(NSString *)cid{
    [self.subcategoryModel getProductSubCategories:cid completion:^(id listSubcategories, NSError * error) {
        if(error == nil){
            
            
            self.subcategoryModel.subcategories = listSubcategories;
            self.subcategories = self.subcategoryModel.subcategories;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
        else{
            NSLog(@"There are no subcategories available");
        }
    }];
    
}


//-(void) getProductSubcategories{
//
//    //    info = NSDictionary.new;
//    [self.subcategoryModel getProductSubcategories:^(NSError * error) {
//        if(error == nil){
//
//            self.subcategories = self.subcategoryModel.subcategories;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.collectionView reloadData];
//            });
//        }
//        else{
//            NSLog(@"There are no subcategories available");
//        }
//    }];
//
//}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //Category * subcategory = self.subcategories[indexPath.item];
//    [cell setCategoryCell:subcategory];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.subcategoryModel.subcategories.count;
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
