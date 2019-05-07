//
//  HomeViewController.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"
#import "TopSeller.h"
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (weak, nonatomic) IBOutlet UICollectionView *colView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@property (strong, nonatomic) HomeViewModel * homeVM;
@property (strong, nonatomic) TopSeller * topSeller;
@property (strong, nonatomic) Category * category;
@property (strong, nonatomic) NSMutableArray<Category *>* categories;

- (IBAction)categoriesButton:(id)sender;
- (IBAction)topSellerButton:(UIButton *)sender;
- (void)setControls;
- (void)getProductCategories;

- (void)getTopSellerCompany;

@end

NS_ASSUME_NONNULL_END
