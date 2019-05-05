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

@interface OrderFormViewController ()

@property (strong, nonatomic) OrderFormViewModel *vm;

@end

@implementation OrderFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = OrderFormViewModel.new;
}

- (void)initializeForm
{
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
    [section addFormRow:row];
    
    // Email
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self emailRowRequired:YES];
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)confirmTapped:(id)sender {
    [[self.tableView superview] endEditing:YES];
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs) {
        NSLog(@"%@", [self formValues]);
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self confirmTapped:nil];
    return shouldReturn;
}

@end
