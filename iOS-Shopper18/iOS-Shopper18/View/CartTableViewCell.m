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
    //[Cart.shared changeProductQuantityAt:sender.tag amount:<#(NSInteger)#>]
    
//    NSString *originalString = self.pPriceLbl.text;
//
//    // Intermediate
//    NSString *numberString;
//    NSScanner *scanner = [NSScanner scannerWithString:originalString];
//    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    // Throw away characters before the first number.
//    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
//
//    // Collect numbers.
//    [scanner scanCharactersFromSet:numbers intoString:&numberString];
//
//    // Result.
//    int number = [numberString integerValue];
//
//    //self.pPriceLbl.text
//    self.pCountLbl.text = [NSString stringWithFormat:@"%ld", self.productCount];
//    self.pPriceLbl.text = [NSString stringWithFormat:@"Unit price: $ %.2ld", (self.productCount * number)];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.productCount = 1;
    //self.pCountLbl.text = [NSString stringWithFormat:@"%ld", Product.];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
