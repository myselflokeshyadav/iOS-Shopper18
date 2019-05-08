//
//  SingleTopSellerViewController.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/8/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "SingleTopSellerViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface SingleTopSellerViewController ()

@end

@implementation SingleTopSellerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLbl.text = self.name;
    self.dealLbl.text =self.deal;
    self.navigationItem.title = self.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgString]
                                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    switch (self.starCount.intValue) {
        case 1:
            self.star1.image = [UIImage imageNamed:@"star"];
            break;
        case 2:
            self.star1.image = [UIImage imageNamed:@"star"];
            self.star2.image = [UIImage imageNamed:@"star"];
            break;
        case 3:
            self.star1.image = [UIImage imageNamed:@"star"];
            self.star2.image = [UIImage imageNamed:@"star"];
            self.star3.image = [UIImage imageNamed:@"star"];
            break;
        case 4:
            self.star1.image = [UIImage imageNamed:@"star"];
            self.star2.image = [UIImage imageNamed:@"star"];
            self.star3.image = [UIImage imageNamed:@"star"];
            self.star4.image = [UIImage imageNamed:@"star"];
            break;
        case 5:
            self.star1.image = [UIImage imageNamed:@"star"];
            self.star2.image = [UIImage imageNamed:@"star"];
            self.star3.image = [UIImage imageNamed:@"star"];
            self.star4.image = [UIImage imageNamed:@"star"];
            self.star5.image = [UIImage imageNamed:@"star"];
            break;
        default:
            break;
    }
}

@end
