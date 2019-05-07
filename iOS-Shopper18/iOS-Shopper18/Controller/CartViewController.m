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


@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Shopping Cart";
    self.pCount = 1;
    [Cart.shared loadProducts:^(BOOL success) {
        if (success) {
//            [self.dataArray addObjectsFromArray:Cart.shared.items];
            self.dataArray = [Cart.shared.items mutableCopy];
            NSLog(@"%@",self.dataArray);
            [self.tblView reloadData];
        }else{
            NSLog(@"Error loading data");
        }
    }];
    
    
//    NSDictionary *testInfo = @{ @"id": @"2",
//                                @"pname": @"test",
//                                @"quantity": @10,
//                                @"prize": @1.4,
//                                @"discription": @"asdfasdfasdf",
//                                @"image": @"testURL.com"
//                                
//                                };
//    
//    Product *product = [Product initWithInfo:testInfo];
//    [FirebaseHandler.shared addProduct:product completion:^(NSError * _Nullable error) {
//        
//    }];
    
    //    [FirebaseHandler.shared cartForUser:kTestUserID completion:^(NSMutableArray * _Nullable result) {
    //        for( id x in result){
    //            NSLog(@"%@", x);
    //        }
    //    }];
    
    //    [FirebaseHandler.shared removeProductFromFirebase:product.pid completion:^(NSError * _Nullable error) {
    //
    //    }];
}

- (void)viewWillAppear:(BOOL)animated{
    //todo
    //pull cart data from firebase.
    [Cart.shared loadProducts:^(BOOL success) {
        if (success) {
            [self.dataArray addObjectsFromArray:Cart.shared.items];
        }else{
            NSLog(@"Error loading data");
        }
    }];
    [self.tblView reloadData];
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
            [self postNonceToServer:@"11"];
            
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
    Product *pObj = [self.dataArray objectAtIndex:indexPath.row];
    //self.totalPrizeLbl.text = cell.pPriceLbl.text;

//
    cell.pNameLbl.text = pObj.name;
    cell.pDescLbl.text = pObj.desc;
    [cell.pImgView sd_setImageWithURL:[NSURL URLWithString:pObj.imageURL]
                 placeholderImage:[UIImage imageNamed:@"No image available"]];
    cell.pPriceLbl.text = [NSString stringWithFormat:@"Item price: $%.2f", pObj.price];
//
//    NSLog(@"%@",[self.dataArray objectAtIndex:indexPath.row]);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray ? self.dataArray.count : 0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tblView reloadData];
    }
}

@end
