//
//  RegisterViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "RegisterViewController.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "RegisterViewModel.h"

@interface RegisterViewController ()

@property (strong, nonatomic) RegisterViewModel *vm;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = RegisterViewModel.new;
}

- (void)initializeForm
{
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    // First name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self fnameRowRequired:YES];
    [section addFormRow:row];
    
    // Last name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self lnameRowRequired:YES];
    [section addFormRow:row];
    
    // Address
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self addressRowRequired:YES];
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
    
    // Password
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self passwordRowRequired:YES];
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)doneTapped:(id)sender {
    [[self.tableView superview] endEditing:YES];
    if (self.isFormValid) {
        NSLog(@"%@", [self formValues]);
        [self.vm register:[self formValues] completion:^(BOOL success, NSString * _Nullable msg) {
            NSLog(@"%@", success? @"Success" : msg);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.lastField && textField == self.lastField) {
        [self doneTapped:nil];
    }
}

@end
