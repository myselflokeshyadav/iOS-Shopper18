//
//  OrderFormViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "OrderFormViewController.h"
#import "OrderFormViewModel.h"
#import "UIViewController+Helpers.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "APIHandler.h"
#import "User.h"
#import "Cart.h"
#import <TWMessageBarManager.h>

@interface OrderFormViewController ()

@property (strong, nonatomic) OrderFormViewModel *vm;

@end

@implementation OrderFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Order Details";
    self.vm = OrderFormViewModel.new;
    [Cart.shared loadProducts:^(BOOL success) {
        
    }];
}

- (void)initializeForm
{
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    User *user = APIHandler.shared.currentUser;
    
    // First name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self floatRowWithTag:@"name" title:@"Name"];
    row.required = YES;
    [self setInputOptionForRow:row option:InputLettersOnly];
    [self floatCellForRow:row].floatLabeledTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self floatCellForRow:row].floatLabeledTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    row.value = user.name;
    [section addFormRow:row];
    
    // Billing Address
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self addressRowRequired:YES];
    row.tag = @"billingadd";
    row.title = @"Billing Address";
    [section addFormRow:row];
    
    // Delivery Address
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self addressRowRequired:YES];
    row.tag = @"deliveryadd";
    row.title = @"Delivery Address";
    [section addFormRow:row];
    
    // Mobile
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self mobileRowRequired:YES];
    row.value = user.mobile;
    [section addFormRow:row];
    
    // Email
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self emailRowRequired:YES];
    row.value = user.email;
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)confirmTapped {
    [[self.tableView superview] endEditing:YES];
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs) {
        [self beginTransaction];
    }
}

- (void)beginTransaction {
    [self promptPayment:^(BOOL success, BOOL canceled, NSError * _Nullable error) {
        if (!success) {
            if (error) {
                [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Error" description:@"Transaction failed, please try again later" type:TWMessageBarMessageTypeSuccess duration:2];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        [self placeOrder];
    }];
}


- (void)promptPayment:(void (^)(BOOL success, BOOL canceled, NSError * _Nullable))completion {
    BTDropInRequest *request = BTDropInRequest.new;
    BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:kclientToken request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
        
        if (error != nil) completion(NO, NO, error);
        else if (result.cancelled) completion(NO, YES, nil);
        else {
            NSString *totalPrice = [NSString stringWithFormat:@"%.2f", Cart.shared.totalPrice / 100];
            [self.vm postToServer:totalPrice completion:^(id _Nullable result, NSError * _Nonnull error) {
                completion(YES, NO, nil);
            }];
            result.paymentOptionType = BTUIKPaymentOptionTypePayPal;
        }
    }];
    
    [self presentViewController:dropIn animated:YES completion:nil];
}


- (void)placeOrder {
    [self.vm placeOrder:self.formValues completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *title = success? @"Success!" : @"Error";
            NSString *msg = success? @"Your order has been placed" : @"Some orders may not have gone through, place check your cart";
            if (success) {
                
            } else {
                [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Thank you!" description:@"Your order has been placed" type:TWMessageBarMessageTypeSuccess duration:2];
            }
            [self dismissViewControllerAnimated:YES completion:^{
                [self alert:title msg:msg completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }];
            
        });
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self confirmTapped];
    return shouldReturn;
}

@end
