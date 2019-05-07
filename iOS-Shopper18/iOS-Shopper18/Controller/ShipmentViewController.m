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
    // Do any additional setup after loading the view.
}


- (IBAction)enterOrderID:(UIButton*)sender {
    
    [self.vm getShipmenTrack:self.orderIDInput.text completionHandler:^(NSError * error){
        if(error == nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.responseLabel.text = self.vm.shipmentTrack.status;
            });

        }else{
            NSLog(@"%@",error);
        }
    }];
}





@end
