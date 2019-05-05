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
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self mobileRowRequired:YES];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self passwordRowRequired:YES];
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)signinTapped:(id)sender {
    [[self.tableView superview] endEditing:YES];
    if (self.isFormValid) {
        NSLog(@"%@", [self formValues]);
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.lastField && textField == self.lastField) {
        [self signinTapped:nil];
    }
}

@end
