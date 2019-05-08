//
//  SingleTopSellerViewController.h
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/8/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingleTopSellerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dealLbl;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* deal;
@property (strong, nonatomic) NSString* imgString;
@property (strong, nonatomic) NSString* starCount;

@end

