//
//  TopSellerCell.h
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopSellerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *sNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *sDealLbl;
@property (weak, nonatomic) IBOutlet UILabel *sRatingLbl;

@property (weak, nonatomic) IBOutlet UIImageView *starImg1;
@property (weak, nonatomic) IBOutlet UIImageView *starImg2;
@property (weak, nonatomic) IBOutlet UIImageView *starImg3;
@property (weak, nonatomic) IBOutlet UIImageView *starImg4;
@property (weak, nonatomic) IBOutlet UIImageView *starImg5;

@end

NS_ASSUME_NONNULL_END
