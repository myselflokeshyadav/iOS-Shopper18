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
}

//- (IBAction)countBtnClick:(UIButton *)sender {
//    if (sender.tag == 100){
//        //minus count btn clicked
//        CartTableViewCell *cartcell = [[CartTableViewCell alloc] init];
//        cartcell.pCountLbl.text = @"-1";
//
//    }else{
//        //plus count btn click
//    }
//
//}

//- (void)dataParser:(id)data
//{
//    if (data) {
//
//    } else {
//        _name = [NSString stringWithFormat:@"Product Name %u",arc4random() % 100];
//        _desc = [NSString stringWithFormat:@"Product Info --- %u",arc4random() % 100];
//        _prize = [NSString stringWithFormat:@"Product Price: %u",arc4random() % 100];
//        _imageURL = [NSString stringWithFormat:@"imageUrl --- %u",arc4random() % 100];
//    }
//}

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

//- (NSMutableArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray new];
//        for (int i = 0; i < 6; i++) {
//            Product *model = [[Product alloc] init];
//            [model dataParser:nil];
//            [_dataArray addObject:model];
//        }
//    }
//    return _dataArray;
//}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    Product *pObj = [self.dataArray objectAtIndex:indexPath.row];
//    
//    cell.minusButtonTapHandler = ^{
//        self.pCount -= 1;
//        cell.pCountLbl.text = [NSString stringWithFormat: @"%d", self.pCount];
//    };
//    cell.plusButtonTapHandler = ^{
//        
//    };
//    
//    cell.pNameLbl.text = pObj.name;
//    cell.pPriceLbl.text = pObj.prize;
//    
//    NSLog(@"%@",[self.dataArray objectAtIndex:indexPath.row]);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray ? self.dataArray.count : 0;
    return 5;
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
