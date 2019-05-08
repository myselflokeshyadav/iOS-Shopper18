//
//  ProductDetailViewController.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailViewModel;
@class Product;

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrize;
@property (weak, nonatomic) IBOutlet UILabel *productQuantity;
@property (weak, nonatomic) IBOutlet UILabel *productDescribtion;

@property (weak, nonatomic) IBOutlet UIButton *btnOne;

@property (weak, nonatomic) IBOutlet UIButton *btnTwo;

@property (weak, nonatomic) IBOutlet UIButton *btnThree;

@property (weak, nonatomic) IBOutlet UIButton *btnFoure;

@property (weak, nonatomic) IBOutlet UIButton *btnFive;

@property (weak, nonatomic) IBOutlet UIView *facebookShareView;
    
    @property (weak, nonatomic) IBOutlet UIView *facebookPhotoShareView;
    
    

@property (strong, nonatomic) ProductDetailViewModel *vm;
@property (strong, nonatomic) Product * product;

-(void)setDetailViewModel:(ProductDetailViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
