//
//  SingleTopSellerViewController.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/8/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "SingleTopSellerViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "UIView+Toast.h"

@interface SingleTopSellerViewController ()

@end

@implementation SingleTopSellerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLbl.text = self.name;
    self.dealLbl.text =self.deal;
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

- (IBAction)ratingBtnClick:(UIButton *)sender {
    [self displayToast];
}

-(void)displayToast{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.view makeToast:@"Rating functionality is not available yet."
                        duration:3.0
                        position:CSToastPositionCenter
                           title:@"Sorry"
                           image:[UIImage imageNamed:@"toast.png"]
                           style:nil
                      completion:^(BOOL didTap) {
                      }];
    });
}

@end
