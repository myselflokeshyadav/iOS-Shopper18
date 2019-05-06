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
#import "Cart.h"

@interface ProductDetailViewController ()
@property (nonatomic, strong) ProductDetailViewModel* viewModel;
@property (nonatomic, strong) Cart *sharedManager;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    self.sharedManager = [Cart shared];
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
    NSString *productDescribTxt = [NSString stringWithFormat:@"%@",self.product.desc];
    self.productDescribtion.text = productDescribTxt;
    NSString  * price = [NSString stringWithFormat:@"%f USD", self.product.price];
    self.productPrize.text = price;
    NSString * urlString = self.product.imageURL;
    NSURL * url = [NSURL URLWithString:urlString];
    [self.productImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No image available"]];

}
- (IBAction)buyProduct:(id)sender {
    [self.sharedManager addProduct:self.product];
    NSString *mess = [NSString stringWithFormat:@"Success in purchasing %@",self.product.name];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!" message:mess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Great!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
