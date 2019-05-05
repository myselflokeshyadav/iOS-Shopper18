//
//  ProductDetailViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailViewModel.h"
#import <libextobjc/EXTScope.h>
#import <SDWebImage/SDWebImage.h>

@interface ProductDetailViewController ()
@property (nonatomic, strong) ProductDetailViewModel* viewModel;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupUI];
//    NSLog(@"%@",self.viewModel.showProductName);
//    NSLog(@"%@",self.viewModel.showDescription);
    [self setupUI];
}

//setter
-(void)setDetailViewModel:(ProductDetailViewModel *)viewModel{
    _viewModel = viewModel;
    self.vm = viewModel;
    self.product = viewModel.product;
}
- (void)setupUI{
    //set up UI by accessing viewModel.stuff
    self.productName.text = self.product.name;
    self.productDescribtion.text = self.product.desc;
    NSString  * price = [NSString stringWithFormat:@"%d", self.product.price];
    self.productPrize.text = price;
    NSString  * quantity = [NSString stringWithFormat:@"%i", self.product.quantity];
    self.productQuantity.text = quantity;
    NSString * urlString = self.product.imageURL;
    NSURL * url = [NSURL URLWithString:urlString];
    [self.productImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No image available"]];

}

@end
