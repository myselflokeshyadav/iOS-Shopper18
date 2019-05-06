//
//  CategoryViewCell.m
//  iOS-Shopper18
//
//  Created by Noh Tewolde on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "CategoryViewCell.h"
#import <SDWebImage/SDWebImage.h>

@implementation CategoryViewCell

-(void)setCategoryCell:(Category * _Nonnull)category{
    self.category = category;
    self.categoryName.text = category.name;
    NSString *urlString = category.imageURL;
    NSURL *url = [NSURL URLWithString:urlString];
    [self.categoryImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No image available"]];
}

-(void)setProductCell:(Product * _Nonnull)product{
    self.product = product;
    self.categoryName.text = product.name;
    
    NSString *urlString = product.imageURL;
    NSURL *url = [NSURL URLWithString:urlString];
    [self.categoryImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No image available"]];
}
@end
