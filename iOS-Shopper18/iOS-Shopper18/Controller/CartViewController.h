//
//  ShoppingCartViewController.h
//  iOS-Shopper18
//
//  Created by SHILEI CUI on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BraintreeCore.h"
#import "BraintreeDropIn.h"
#import "BTDropInViewController.h"
#import "BraintreePayPal.h"
#import "FirebaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalPrizeLbl;

@property (nonatomic, assign) NSInteger* pCount;

@end

NS_ASSUME_NONNULL_END
