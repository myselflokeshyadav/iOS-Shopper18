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
@property (readwrite) NSInteger itemsBoughtCount;
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
    //set 1 quantity button default
    self.btnOne.backgroundColor = kColorPrimeOrange;
    self.itemsBoughtCount = self.btnOne.tag;
    //set up UI by accessing viewModel.stuff
    self.productName.text = self.product.name;
    NSString *productDescribTxt = [NSString stringWithFormat:@"%@",self.product.desc];
    self.productDescribtion.text = productDescribTxt;
    NSString* formattedNumber = [NSString stringWithFormat:@"$%.02f", self.product.price];
    self.productPrize.text = formattedNumber;
    NSString * urlString = self.product.imageURL;
    NSURL * url = [NSURL URLWithString:urlString];
    [self.productImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No image available"]];
}

- (IBAction)buyProduct:(id)sender {
    for( int i = 0; i <self.itemsBoughtCount; i ++){
    [self.sharedManager addProduct:self.product];
    }
    NSString *mess = [NSString stringWithFormat:@"Success in purchasing %ld of %@",(long)self.itemsBoughtCount,self.product.name];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Add to Cart!" message:mess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Great!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)pickQuantity:(UIButton*)sender {
    self.btnOne.backgroundColor = UIColor.whiteColor;
    self.btnTwo.backgroundColor = UIColor.whiteColor;
    self.btnThree.backgroundColor = UIColor.whiteColor;
    self.btnFoure.backgroundColor = UIColor.whiteColor;
    self.btnFive.backgroundColor = UIColor.whiteColor;

    UIColor *orange = kColorPrimeOrange;
    
    NSInteger tag = [sender tag];
    switch (tag) {
        case 1:
            self.itemsBoughtCount = tag;
            sender.backgroundColor = orange;
            break;
        case 2:
            self.itemsBoughtCount = tag;
            sender.backgroundColor = orange;
            break;
        case 3:
            self.itemsBoughtCount = tag;
            sender.backgroundColor = orange;
            break;
        case 4:
            self.itemsBoughtCount = tag;
            sender.backgroundColor = orange;
            break;
        case 5:
            self.itemsBoughtCount = tag;
            sender.backgroundColor = orange;
            break;
        default:
            break;
    }
}




@end
