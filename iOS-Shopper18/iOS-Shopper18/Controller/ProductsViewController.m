//
//  ProductsViewController.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProductsViewController.h"
#import "CategoryViewCell.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productList = NSMutableArray.new;
    self.productVModel = ProductsViewModel.new;
    [self getProducts:self.subcategory.scid];
}

- (void)getProducts:(NSString *)cid{
    [self.productVModel getProducts:cid completion:^(id listSubcategories, NSError * error) {
        if(error == nil){
            
            
            self.productVModel.productList = listSubcategories;
            //            self.subcategories = self.subcategoryModel.subcategories;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
        else{
            NSLog(@"There are no products available");
        }
    }];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Product * product = self.productList[indexPath.item];
    [cell setCategoryCell:product];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productVModel.productList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
