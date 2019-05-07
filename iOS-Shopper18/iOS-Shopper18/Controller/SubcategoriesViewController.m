//
//  SubcategoriesViewController.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "SubcategoriesViewController.h"
#import "CategoryViewCell.h"
#import "ProductsViewController.h"

@interface SubcategoriesViewController ()

@end

@implementation SubcategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subcategories = NSMutableArray.new;
    self.subcategoryModel = SubcategoriesViewModel.new;
    [self getProductSubCategories:self.category.cid];
}

//Mark:  Handle failing links
- (void)getProductSubCategories:(NSString *)cid{
    [self.subcategoryModel getProductSubCategories:cid completion:^(id _Nullable listSubcategories, NSError * _Nullable error) {
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Category * subcategory = self.subcategories[indexPath.item];
    [cell setCategoryCell:subcategory];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!self.subcategoryModel.subcategories) return 0;
    return self.subcategoryModel.subcategories.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Subcategory * subcategory = self.subcategories[indexPath.item];
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Category" bundle:nil];
    ProductsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ProductsViewController"];
    vc.subcategory = subcategory;
    vc.category = self.category;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
