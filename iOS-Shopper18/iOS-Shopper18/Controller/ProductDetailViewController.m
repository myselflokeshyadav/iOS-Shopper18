//
//  ProductDetailViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProductDetailViewController.h"
//#import <libextobjc/EXTScope.h>
//#import <SDWebImage/SDWebImage.h>

@interface ProductDetailViewController ()
@property (nonatomic, strong) ProductDetailViewModel* viewModel;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupUI];
//    NSLog(@"%@",self.viewModel.showProductName);
//    NSLog(@"%@",self.viewModel.showDescription);
}

//setter
-(void)setDetailViewModel:(ProductDetailViewModel *)viewModel{
    _viewModel = viewModel;
}
//- (void)setupUI{
//    //set up UI by accessing viewModel.stuff
//    //    self.productName.text = self.detailViewModel;
//    //    self.productDescribtion.text = self.detailViewModel.pDescription;
//    //[imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//
//}

@end
