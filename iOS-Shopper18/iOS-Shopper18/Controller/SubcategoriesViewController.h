//
//  SubcategoriesViewController.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubcategoriesViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubcategoriesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) SubcategoriesViewModel * subcategoryModel;
@property (strong, nonatomic) NSMutableArray<Category *> *subcategories;

- (void)getProductSubcategories;


@end

NS_ASSUME_NONNULL_END
