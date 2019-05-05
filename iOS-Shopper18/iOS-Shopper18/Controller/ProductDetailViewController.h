//
//  ProductDetailViewController.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrize;
@property (weak, nonatomic) IBOutlet UILabel *productQuantity;
@property (weak, nonatomic) IBOutlet UILabel *productDescribtion;

@property (strong, nonatomic) ProductDetailViewModel *vm;

-(void)setDetailViewModel:(ProductDetailViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
