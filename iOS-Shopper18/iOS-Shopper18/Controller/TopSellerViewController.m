//
//  TopSellerViewController.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "TopSellerViewController.h"
#import "TopSellerCell.h"
#import "TopSellerViewModel.h"
#import "TopSeller.h"
#import <SDWebImage/SDWebImage.h>
#import "SingleTopSellerViewController.h"

@interface TopSellerViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *colView;
@property (strong,nonatomic) TopSellerViewModel *topsellerVM;




@end

@implementation TopSellerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Top Sellers";
    self.navigationItem.backBarButtonItem.title = @" ";
    self.topsellerVM = TopSellerViewModel.new;
    
    [self.topsellerVM getTopSellers:^(BOOL success, NSString * _Nullable error) {
        if (success == YES){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.colView reloadData];
            });
        }
        else{
            NSLog(@"Can't get data from API Services");
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TopSellerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topsellerCell" forIndexPath:indexPath];
    TopSeller *tsObj = [self.topsellerVM topSellerAt:indexPath.item];
    
    cell.sNameLbl.text = [NSString stringWithFormat:@"%@", tsObj.name];
    cell.sDealLbl.text = [NSString stringWithFormat:@"Deal: %@", tsObj.deal];
    switch (tsObj.rating.intValue) {
        case 1:
            cell.starImg1.image = [UIImage imageNamed:@"star"];
            break;
        case 2:
            cell.starImg1.image = [UIImage imageNamed:@"star"];
            cell.starImg2.image = [UIImage imageNamed:@"star"];
            break;
        case 3:
            cell.starImg1.image = [UIImage imageNamed:@"star"];
            cell.starImg2.image = [UIImage imageNamed:@"star"];
            cell.starImg3.image = [UIImage imageNamed:@"star"];
            break;
        case 4:
            cell.starImg1.image = [UIImage imageNamed:@"star"];
            cell.starImg2.image = [UIImage imageNamed:@"star"];
            cell.starImg3.image = [UIImage imageNamed:@"star"];
            cell.starImg4.image = [UIImage imageNamed:@"star"];
            break;
        case 5:
            cell.starImg1.image = [UIImage imageNamed:@"star"];
            cell.starImg2.image = [UIImage imageNamed:@"star"];
            cell.starImg3.image = [UIImage imageNamed:@"star"];
            cell.starImg4.image = [UIImage imageNamed:@"star"];
            cell.starImg5.image = [UIImage imageNamed:@"star"];
            break;
        default:
            break;
    }
    cell.sRatingLbl.text = @"Rating:";
    [cell.logoImgView sd_setImageWithURL:[NSURL URLWithString:tsObj.logo]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.topsellerVM.numTopSellers;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SingleTopSellerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleTopSellerViewController"];
    TopSeller *tsObj = [self.topsellerVM topSellerAt:indexPath.row];
    
    //vc.nameLbl.text = [NSString stringWithFormat:@"%@", tsObj.name];
    vc.name = [NSString stringWithFormat:@"%@", tsObj.name];
    vc.deal = [NSString stringWithFormat:@"Deal: %@", tsObj.deal];
    vc.imgString = tsObj.logo;
    vc.starCount = tsObj.rating;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
