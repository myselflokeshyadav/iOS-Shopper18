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
@property (strong,nonatomic) NSString *shipmentIDDisplay;
@property (strong,nonatomic) NSString *shipmentStatusDisplay;

@end

@implementation ShipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = ShipmentViewModel.new;
    self.orderID = @"2147484660";
    [self getShipmentTrackingInfo];
    // Do any additional setup after loading the view.
}

-(void)getShipmentTrackingInfo{
    [self.vm getShipmenTrack:self.orderID completionHandler:^(NSError * error){
        if(error == nil){
            NSLog(@"shipmentID is %@",self.vm.shipmentTrack.sid);
            NSLog(@"shipmentStatus is %@",self.vm.shipmentTrack.sid);
            ShipmentTrack *fuckItIAmMakingACopy = self.vm.shipmentTrack;
            NSString *shipmentIDDict = fuckItIAmMakingACopy.sid;
            self.shipmentIDDisplay = shipmentIDDict;
            NSLog(@"THE END");
        }else{
            NSLog(@"%@",error);
        }
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
