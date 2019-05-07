//
//  ProductsViewController.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProductsViewController.h"
#import "CategoryViewCell.h"
#import "ProductDetailViewController.h"
#import "ProductDetailViewModel.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productList = NSMutableArray.new;
    self.productVModel = ProductsViewModel.new;
    [self getProducts:self.category.cid scid:self.subcategory.scid];
}

- (void)getProducts:(NSString *)cid scid:(NSString *)scid{
    
    [self.productVModel getProducts:cid scid:scid completion:^(id productList, NSError * error) {
        if(error == nil){
            
            
            self.productVModel.productList = productList;
            self.productList = self.productVModel.productList;
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
    [cell setProductCell:product];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productVModel.productList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ProductDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    Product *product = self.productList[indexPath.item];
//    ProductDetailViewModel * productVM = [[ProductDetailViewModel alloc] initWithProduct:product];
    ProductDetailViewModel * productVM = ProductDetailViewModel.new;
    productVM = [productVM initWithProduct:product];
    [detailVC setDetailViewModel:productVM];
    [self.navigationController pushViewController:detailVC animated:true];
}




@end
