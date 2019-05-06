//
//  ShipmentViewController.h
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShipmentViewController : UIViewController

//@property (weak,nonatomic) IBOutlet NSString order_id;

-(void)getShipmentTrackingInfo;

@property (weak, nonatomic) IBOutlet UITextField *orderIDInput;

@property (weak, nonatomic) IBOutlet UILabel *responseLabel;




@end



NS_ASSUME_NONNULL_END
