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

@end

NS_ASSUME_NONNULL_END
