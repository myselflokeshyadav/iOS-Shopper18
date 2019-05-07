//
//  CartTableViewCell.h
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cart.h"
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pImgView;
@property (weak, nonatomic) IBOutlet UILabel *pNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *pDescLbl;
@property (weak, nonatomic) IBOutlet UILabel *pPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *pCountLbl;

@property (nonatomic, copy) void(^plusButtonTapHandler)(void);
@property (nonatomic, copy) void(^minusButtonTapHandler)(void);

@end

NS_ASSUME_NONNULL_END
