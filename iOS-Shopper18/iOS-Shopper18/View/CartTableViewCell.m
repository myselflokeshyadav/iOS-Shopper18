//
//  CartTableViewCell.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (IBAction)addButtonTapped:(UIButton *)sender
{
    self.plusButtonTapHandler();
    
}

- (IBAction)minusButtonTapped:(UIButton *)sender
{
    self.minusButtonTapHandler();
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
