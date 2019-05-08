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
#import "TopSellerViewModel.h"
#import "SubcategoriesViewController.h"
#import "CategoriesViewController.h"
#import "SingleTopSellerViewController.h"
#import "TopSeller.h"

@interface HomeViewController ()
@property (strong,nonatomic) TopSellerViewModel *topsellerVM;
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

- (IBAction)categoriesButton:(id)sender {
    CategoriesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)topSellerButton:(UIButton *)sender {
    TopSellerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TopSellerViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(collectionView == self.colView){
        TopSellerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topsellerCell" forIndexPath:indexPath];
        TopSeller *tsObj = [self.homeVM topSellerAt:indexPath.item];
        [cell.logoImgView sd_setImageWithURL:[NSURL URLWithString:tsObj.logo]
                            placeholderImage:kImagePlaceholder];
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
        
        SingleTopSellerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleTopSellerViewController"];
        TopSeller *tsObj = [self.homeVM topSellerAt:indexPath.item];
        vc.name = [NSString stringWithFormat:@"%@", tsObj.name];
        vc.deal = [NSString stringWithFormat:@"Deal: %@", tsObj.deal];
        vc.imgString = tsObj.logo;
        vc.starCount = tsObj.rating;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        Category * category = self.categories[indexPath.item];
        SubcategoriesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubcategoriesViewController"];
        vc.category = category;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
