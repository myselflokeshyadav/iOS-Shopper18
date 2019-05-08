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
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ProductDetailViewController ()
@property (nonatomic, strong) ProductDetailViewModel* viewModel;
@property (nonatomic, strong) Cart *sharedManager;
@property (readwrite) NSInteger itemsBoughtCount;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    self.sharedManager = [Cart shared];
    [super viewDidLoad];
    [self setupUI];
    self.navigationItem.title = @"Product Details";
    
    //FACEBOOK SHARE STARTS HERE
    //Get current picture
    NSString * urlString = self.product.imageURL;
    NSURL * url = [NSURL URLWithString:urlString];
    UIImageView* productPic = UIImageView.new;
    [productPic sd_setImageWithURL:url placeholderImage:kImagePlaceholder];
    //facebook photo share button setup
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc]init];
    photo.image = productPic.image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
    content.photos = @[photo];
    FBSDKShareButton *button = [[FBSDKShareButton alloc] init];
    button.shareContent = content;
    [self.facebookPhotoShareView addSubview:button];
    //facebook url share button setup
    FBSDKShareLinkContent *contents = [[FBSDKShareLinkContent alloc] init];
    contents.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    FBSDKShareButton *button2 = [[FBSDKShareButton alloc] init];
    button2.shareContent = contents;
    [self.facebookShareView addSubview:button2];
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
    NSString* formattedNumber = [NSString stringWithFormat:@"$%.02f", self.product.price / 100];
    self.productPrize.text = formattedNumber;
    NSString * urlString = self.product.imageURL;
    NSURL * url = [NSURL URLWithString:urlString];
    [self.productImage sd_setImageWithURL:url placeholderImage:kImagePlaceholder];
}

- (IBAction)buyProduct:(id)sender {
    [self.sharedManager addProduct:self.product with:self.itemsBoughtCount];
    self.tabBarController.tabBar.items[1].badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)Cart.shared.items.count];
    NSString *mess = [NSString stringWithFormat:@"%@ x %ld added to cart.",self.product.name, (long)self.itemsBoughtCount];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Added to Cart!" message:mess preferredStyle:UIAlertControllerStyleAlert];
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
    self.itemsBoughtCount = tag;
    sender.backgroundColor = orange;
    
    //  HOOOOOF
//    switch (tag) {
//        case 1:
//            self.itemsBoughtCount = tag;
//            sender.backgroundColor = orange;
//            break;
//        case 2:
//            self.itemsBoughtCount = tag;
//            sender.backgroundColor = orange;
//            break;
//        case 3:
//            self.itemsBoughtCount = tag;
//            sender.backgroundColor = orange;
//            break;
//        case 4:
//            self.itemsBoughtCount = tag;
//            sender.backgroundColor = orange;
//            break;
//        case 5:
//            self.itemsBoughtCount = tag;
//            sender.backgroundColor = orange;
//            break;
//        default:
//            break;
//    }
}




@end
