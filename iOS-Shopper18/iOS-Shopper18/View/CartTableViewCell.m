//
//  CartTableViewCell.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell


- (IBAction)countBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        if (self.productCount > 1) {
            self.productCount -= 1;
        }
    } else {
        self.productCount += 1;
    }
    self.pCountLbl.text = [NSString stringWithFormat:@"%ld", self.productCount];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.productCount = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
