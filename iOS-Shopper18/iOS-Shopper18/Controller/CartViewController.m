//
//  ShoppingCartViewController.m
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "CartViewController.h"
#import "Product.h"
#import "CartTableViewCell.h"
#import "Cart.h"
#import <SDWebImage/SDWebImage.h>
#import "ProductDetailViewController.h"
#import "ProductDetailViewModel.h"


@interface CartViewController ()<BTDropInViewControllerDelegate, BTViewControllerPresentingDelegate>
@property (nonatomic, strong) BTPayPalDriver *payPalDriver;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *noProductInfoLbl;
@property (nonatomic, assign) float totalPaidPrice;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.totalPaidPrice = 0;
    self.navigationItem.title = @"Shopping Cart";
    [self loadProductFromFirebase];
}

- (void)viewWillAppear:(BOOL)animated{
    //pull cart data from firebase.
    [self loadProductFromFirebase];
}

- (void)loadProductFromFirebase {
    [Cart.shared loadProducts:^(BOOL success) {
        if (success) {
            
            self.totalPaidPrice = 0;
            if (Cart.shared.items.count == 0){
                self.tabBarController.tabBar.items[1].badgeValue = nil;
                self.checkoutBtnOutlet.enabled = NO;
                [self.noProductInfoLbl setHidden:NO];
                self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total: $%.2f",self.totalPaidPrice/100];
            }else{
                self.tabBarController.tabBar.items[1].badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)Cart.shared.items.count];
                [self.noProductInfoLbl setHidden:YES];
                for (int i = 0; i < Cart.shared.items.count; i++){
                    self.totalPaidPrice += Cart.shared.items[i].price * Cart.shared.items[i].quantity;
                }
                self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total: $%.2f",self.totalPaidPrice/100];
                [self.tblView reloadData];
            }
        }else{
            NSLog(@"Error loading data");
        }
    }];
}

- (IBAction)checkoutBtnClick:(UIButton *)sender {
    [self showDropIn:kclientToken];
}

- (void)showDropIn:(NSString *)clientTokenOrTokenizationKey {
    BTDropInRequest *request = [[BTDropInRequest alloc] init];
    BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:clientTokenOrTokenizationKey request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"ERROR");
        } else if (result.cancelled) {
            NSLog(@"CANCELLED");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self postNonceToServer:[NSString stringWithFormat:@"%.2f",self.totalPaidPrice/100]];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            [self customAlertView:@"CheckOut Status" errorMessage:@"Payment success!!"];
            result.paymentOptionType = BTUIKPaymentOptionTypePayPal;
        }
    }];
    [self presentViewController:dropIn animated:YES completion:nil];
}

- (void) customAlertView: (NSString*)title errorMessage:(NSString*)errorMessage{
    UIAlertController *alertVC1 = [UIAlertController alertControllerWithTitle:title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                           }];
    [alertVC1 addAction:defaultAction1];
    [self presentViewController:alertVC1 animated:YES completion:nil];
}

- (void)postNonceToServer:(NSString *)amount {
    // Update URL with your server
    NSURL *paymentURL = [NSURL URLWithString:@"http://127.0.0.1:3000/payment"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:paymentURL];
    request.HTTPBody = [[NSString stringWithFormat:@"amount=%@", amount] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle success and failure
        NSLog(@"Post request success!!");
    }] resume];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Product *pObj = [Cart.shared.items objectAtIndex:indexPath.row];
    //__weak CartTableViewCell *weakcell = cell;
    cell.plusButtonTapHandler = ^{
        if (pObj.quantity < 10){
            pObj.quantity += 1;
            [Cart.shared changeProductQuantityAt:indexPath.row amount:pObj.quantity];
            cell.pCountLbl.text = [NSString stringWithFormat: @"%ld",(long)pObj.quantity];
            cell.pPriceLbl.text = [NSString stringWithFormat:@"Subtotal: $%.2f", pObj.totalPrice/100];
            self.totalPaidPrice += pObj.price;
            self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total: $%.2f",self.totalPaidPrice/100];
            cell.minusBtnOutlet.enabled = YES;
            
        }else{
            cell.pulsBtnOutlet.enabled = NO;
        }
    };
    cell.minusButtonTapHandler = ^{
        if (pObj.quantity > 1){
            pObj.quantity -= 1;
            [Cart.shared changeProductQuantityAt:indexPath.row amount:pObj.quantity];
            cell.pCountLbl.text = [NSString stringWithFormat: @"%ld",(long)pObj.quantity];
            cell.pPriceLbl.text = [NSString stringWithFormat:@"Subtotal: $%.2f", pObj.totalPrice/100];
            self.totalPaidPrice -= pObj.price;
            self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total: $%.2f",self.totalPaidPrice/100];
            cell.pulsBtnOutlet.enabled = YES;
        }else{
            cell.minusBtnOutlet.enabled = NO;
        }
    };
    cell.pNameLbl.text = pObj.name;
    //cell.pDescLbl.text = pObj.desc;
    cell.itemPriceLbl.text = [NSString stringWithFormat:@"$%.2f", pObj.price/100];
    [cell.pImgView sd_setImageWithURL:[NSURL URLWithString:pObj.imageURL]
                 placeholderImage:kImagePlaceholder];
    cell.pPriceLbl.text = [NSString stringWithFormat:@"Subtotal: $%.2f", pObj.totalPrice/100];
    cell.pCountLbl.text = [NSString stringWithFormat: @"%ld",(long)pObj.quantity];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return Cart.shared.items ? Cart.shared.items.count : 0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [Cart.shared removeProduct:indexPath.row];
        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self loadProductFromFirebase];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"hahaha");
    ProductDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    Product *product = Cart.shared.items[indexPath.row];
    ProductDetailViewModel * productVM = ProductDetailViewModel.new;
    productVM = [productVM initWithProduct:product];
    [detailVC setDetailViewModel:productVM];
    [self.navigationController pushViewController:detailVC animated:true];
    
}

@end
