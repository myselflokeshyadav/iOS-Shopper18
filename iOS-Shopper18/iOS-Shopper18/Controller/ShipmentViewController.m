//
//  ShipmentViewController.m
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ShipmentViewController.h"
#import "APIHandler.h"
#import "ShipmentViewModel.h"

@interface ShipmentViewController ()
@property (strong, nonatomic) NSString* orderID;
@property (strong,nonatomic) ShipmentViewModel* vm;

@end

@implementation ShipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = ShipmentViewModel.new;
    self.orderID = @"2147484660";
    self.navigationItem.title = @"Shipment Tracking";
    // Do any additional setup after loading the view.
}


- (IBAction)enterOrderID:(UIButton*)sender {
    
    [self.vm shipment:self.orderIDInput.text completionHandler:^(NSError * error){
        if(error == nil){
            if(self.vm.shipmentTrack.status != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.responseLabel.text = self.vm.shipmentTrack.status;
                [self raiseAlert];
            });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                [self raiseErrorAlert];
                });
            }
        }else{
            NSLog(@"%@",error);
        }
    }];

    
}

- (void)raiseAlert{
    NSString *mess = [NSString stringWithFormat:@"Your shipment status is *%@*",self.responseLabel.text];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Result" message:mess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){self.orderIDInput.text = @"";}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)raiseErrorAlert{
    NSString *mess = [NSString stringWithFormat:@"Your order ID is incorrect"];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Result" message:mess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}




@end
