//
//  CategoryViewCell.h
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;

@property (assign, nonatomic) Category * category;
@property (assign, nonatomic) Product * product;
-(void)setCategoryCell:(Category * _Nonnull)category;
-(void)setProductCell:(Product * _Nonnull)product;

@end

NS_ASSUME_NONNULL_END
