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
}

- (void)viewWillAppear:(BOOL)animated{
    //pull cart data from firebase.
    [Cart.shared loadProducts:^(BOOL success) {
        if (success) {
            if (Cart.shared.items.count == 0){
                self.checkoutBtnOutlet.enabled = NO;
            }else{
            [self.noProductInfoLbl setHidden:YES];
            for (int i = 0; i < Cart.shared.items.count; i++){
                self.totalPaidPrice += Cart.shared.items[i].price;
            }
            self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total price: $%.2f",self.totalPaidPrice];
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
            // Use the BTDropInResult properties to update your UI
            // result.paymentOptionType
            // result.paymentMethod
            // result.paymentIcon
            // result.paymentDescription
            [self postNonceToServer:[NSString stringWithFormat:@"%.2f",self.totalPaidPrice]];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertController *alertVC1 = [UIAlertController alertControllerWithTitle:@"CheckOut Status" message:@"Payment success!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       NSLog(@"action = %@", action);
                                                                   }];
            [alertVC1 addAction:defaultAction1];
            [self presentViewController:alertVC1 animated:YES completion:nil];
            result.paymentOptionType = BTUIKPaymentOptionTypePayPal;
        }
    }];
    [self presentViewController:dropIn animated:YES completion:nil];
    
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
        
        pObj.quantity += 1;
        cell.pCountLbl.text = [NSString stringWithFormat: @"%ld",(long)pObj.quantity];
        cell.pPriceLbl.text = [NSString stringWithFormat:@"Item price: $%.2f", pObj.totalPrice];
        self.totalPaidPrice += pObj.price;
        self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total price: $%.2f",self.totalPaidPrice];
    };
    cell.minusButtonTapHandler = ^{
        if (pObj.quantity > 1){
            pObj.quantity -= 1;
            cell.pCountLbl.text = [NSString stringWithFormat: @"%ld",(long)pObj.quantity];
            cell.pPriceLbl.text = [NSString stringWithFormat:@"Item price: $%.2f", pObj.totalPrice];
            self.totalPaidPrice -= pObj.price;
            self.totalPrizeLbl.text = [NSString stringWithFormat: @"Total price: $%.2f",self.totalPaidPrice];
        }
    };
    cell.pNameLbl.text = pObj.name;
    cell.pDescLbl.text = pObj.desc;
    [cell.pImgView sd_setImageWithURL:[NSURL URLWithString:pObj.imageURL]
                 placeholderImage:[UIImage imageNamed:@"No image available"]];
    cell.pPriceLbl.text = [NSString stringWithFormat:@"Item price: $%.2f", pObj.totalPrice];
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
        
        [Cart.shared.items removeObjectAtIndex:indexPath.row];
        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [Cart.shared removeProduct:indexPath.row];

    }
}

@end
