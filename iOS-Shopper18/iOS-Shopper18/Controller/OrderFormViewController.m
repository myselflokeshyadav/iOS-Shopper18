//
//  OrderFormViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/4/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "OrderFormViewController.h"
#import "OrderFormViewModel.h"
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
    
    self.vm = OrderFormViewModel.new;
    [Cart.shared loadProducts:^(BOOL success) {
        
    }];
}

- (void)initializeForm
{
    APIHandler.shared.apiKey = @"31bd6630cdc9f58af3d048f9e650e2d1";
    APIHandler.shared.userID = @"1750";
    User *user = [User initWithInfo:@{@"firstname":@"Test",
                                      @"lastname":@"TestLast",
                                      @"mobile":@"1234560",
                                      @"email":@"test@test.com"
                                      
                                      }];
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
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
        NSLog(@"%@", [self formValues]);
        [self.vm placeOrder:self.formValues completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Thank you!" description:@"Your order has been placed" type:TWMessageBarMessageTypeSuccess duration:2];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self confirmTapped];
    return shouldReturn;
}

@end
