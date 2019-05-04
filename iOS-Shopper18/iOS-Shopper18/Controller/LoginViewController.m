//
//  LoginViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "LoginViewController.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSection];
    
    [form addFormSection:section];
    
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"mobile" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Mobile"];
    row.required = YES;
    [self floatCellForRow:row].textFieldMaxNumberOfCharacters = @10;
    [self setKeyboardForRow:row keyboardType:UIKeyboardTypePhonePad];
    [self setTagForRow:row tag:0];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Password"];
    row.required = YES;
    [section addFormRow:row];
    
    self.form = form;
}


@end
