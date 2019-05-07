//
//  CategoriesViewController.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) CategoriesViewModel * categoryModel;
@property (strong, nonatomic) NSMutableArray<Category *> *categories;

- (void)getProductCategories;


@end

NS_ASSUME_NONNULL_END
