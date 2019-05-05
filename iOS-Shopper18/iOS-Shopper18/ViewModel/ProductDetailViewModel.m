//
//  ProductDetailViewModel.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProductDetailViewModel.h"
#import "Product.h"

@interface ProductDetailViewModel ()

@property (nonatomic, strong) Product *product;

@end

@implementation ProductDetailViewModel

#pragma mark - Liftcycle

+ (instancetype)initWithProduct:(Product *)product{
    ProductDetailViewModel *vm = ProductDetailViewModel.new;
    if (vm) vm.product = product;
    return vm;
}

#pragma mark - Data Source

-(NSString *)productName{
    return @"Products";
}
-(NSString *)showProductName{
    Product *curProduct = [self product];
    return [NSString stringWithFormat:@"Product: %@",curProduct.name];
}
-(NSString *)showDescription{
    Product *curProduct = [self product];
    return [NSString stringWithFormat:@"Description: %@",curProduct.desc];
}

@end
