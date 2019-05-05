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

@interface CategoriesViewController ()

@property (assign, nonatomic) NSDictionary * info;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.info = NSDictionary.new;
    self.categories = NSMutableArray.new;
    self.categoryModel = CategoriesViewModel.new;
    [self getProductCategories];
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
    CategoryViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Category * category = self.categories[indexPath.item];
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Category" bundle:nil];
    SubcategoriesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SubcategoriesViewController"];
    vc.category = category;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
