//
//  HomeViewController.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "HomeViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "TopSellerCell.h"
#import "CategoryViewCell.h"
#import "TopSellerViewController.h"
#import "SubcategoriesViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeVM = HomeViewModel.new;
    self.topSeller = TopSeller.new;
    self.category = Category.new;
    [self setControls];
}

-(void)setControls{
    self.topSellerImage.image = [UIImage imageNamed:@"home"];
    self.topSellerProductLabel.text = @"Welcome";
    [self getTopSellerCompany];
    [self getProductCategories];
}

-(void)getTopSellerCompany{
    [self.homeVM getTopSellers:^(BOOL success, NSString * _Nullable error) {
        if (success == YES){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.colView reloadData];
            });
        }
        else{
            NSLog(@"There are no topSellers available");
        }
    }];
}

-(void) getProductCategories{
    //    info = NSDictionary.new;
    [self.homeVM getProductCategories:^(NSError * error) {
        if(error == nil){
            
            self.categories = self.homeVM.categories;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.categoryCollectionView reloadData];
            });
        }
        else{
            NSLog(@"There are no categories available");
        }
    }];
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(collectionView == self.colView){
        TopSellerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topsellerCell" forIndexPath:indexPath];
        TopSeller *tsObj = [self.homeVM topSellerAt:indexPath.item];
        [cell.logoImgView sd_setImageWithURL:[NSURL URLWithString:tsObj.logo]
                            placeholderImage:[UIImage imageNamed:@"No image available"]];
        return cell;
    }
    else{
        CategoryViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        Category * category = self.categories[indexPath.item];
        [cell setCategoryCell:category];
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.colView){
        return self.homeVM.numTopSellers;
    }
    else{
        return self.homeVM.categories.count;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.colView){
        TopSellerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TopSellerViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else{
        Category * category = self.categories[indexPath.item];
        SubcategoriesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubcategoriesViewController"];
        vc.category = category;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat size = collectionView.bounds.size.width / 2;
//    if(collectionView == self.colView){
//        TopSellerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TopSellerViewController"];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
//    return CGSizeMake(size - 20, size + 25);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 10, 0, 10);
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

@end
