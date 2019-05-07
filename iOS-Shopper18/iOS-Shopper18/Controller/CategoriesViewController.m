//
//  CategoriesViewController.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoryViewCell.h"
#import "SubcategoriesViewController.h"
#import "TopSellerViewController.h"

@interface CategoriesViewController ()

@property (assign, nonatomic) NSDictionary * info;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = NSMutableArray.new;
    self.categoryModel = CategoriesViewModel.new;
    [self getProductCategories];
    self.navigationItem.title = @"Categories";
    self.navigationItem.backBarButtonItem.title = @" ";
    self.navigationItem.leftBarButtonItem.title = @" ";
    self.navigationItem.rightBarButtonItem.title = @" ";
}

-(void) getProductCategories{
    //    info = NSDictionary.new;
    [self.categoryModel getProductCategories:^(NSError * error) {
        if(error == nil){
            
            self.categories = self.categoryModel.categories;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
        else{
            NSLog(@"There are no categories available");
        }
    }];
    
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Category * category = self.categories[indexPath.item];
    [cell setCategoryCell:category];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryModel.categories.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Category * category = self.categories[indexPath.item];
    SubcategoriesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubcategoriesViewController"];
    vc.category = category;
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

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

@end
