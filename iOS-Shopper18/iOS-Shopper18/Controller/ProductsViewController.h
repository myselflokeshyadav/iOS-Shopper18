//
//  ProductsViewController.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsViewModel.h"
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) ProductsViewModel * productVModel;
@property (strong, nonatomic) NSMutableArray<Product *> *productList;
@property(assign, nonatomic) Subcategory * subcategory;
@property(assign, nonatomic) Category * category;

- (void)getProducts:(NSString *)cid scid:(NSString *)sid;

@end

NS_ASSUME_NONNULL_END
