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
#import "UIView+Toast.h"

@interface SubcategoriesViewController ()

@end

@implementation SubcategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subcategories = NSMutableArray.new;
    self.subcategoryModel = SubcategoriesViewModel.new;
    [self getProductSubCategories:self.category.cid];
    self.navigationItem.title = @"Subcategories";
}

// Mark:  Handle failing links
- (void)getProductSubCategories:(NSString *)cid{
    [self.subcategoryModel getProductSubCategories:cid completion:^(id _Nullable listSubcategories, NSError * _Nullable error) {
        if(error == nil){
            self.subcategoryModel.subcategories = listSubcategories;
            self.subcategories = self.subcategoryModel.subcategories;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                if(self.subcategoryModel.subcategories.count == 0){
                    [self displayToast];
                }
            });
        }
        else{
            NSLog(@"There are no subcategories available");
        }
    }];
    
}

-(void)displayToast{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(self.subcategoryModel.subcategories.count == 0){
            [self.view makeToast:@"This subcategory does not exist."
                        duration:3.0
                        position:CSToastPositionCenter
                           title:@"Sorry"
                           image:[UIImage imageNamed:@"toast.png"]
                           style:nil
                      completion:^(BOOL didTap) {
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
        }
    });
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
    ProductsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsViewController"];
    vc.subcategory = subcategory;
    vc.category = self.category;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = collectionView.bounds.size.width / 2;
    
    return CGSizeMake(size - 8, size + 25);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 0, 10);
}


@end
