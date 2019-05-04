//
//  RegisterViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "RegisterViewController.h"
#import "FloatLabeledTextFieldCell.h"

@implementation RegisterViewController


- (void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"fname" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"First Name"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"lname" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Last Name"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"address" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Address"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"mobile" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Mobile"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"email" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Email"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Password"];
    row.required = YES;
    [section addFormRow:row];
    
    self.form = form;
    
}

@end
