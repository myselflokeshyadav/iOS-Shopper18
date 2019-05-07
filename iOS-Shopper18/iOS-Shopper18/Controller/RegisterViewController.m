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
#import <TWMessageBarManager.h>

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
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs) {
        NSLog(@"%@", [self formValues]);
        [self.vm register:[self formValues] completion:^(BOOL success, NSString * _Nullable msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    id vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTab"];
                    [self.navigationController presentViewController:vc animated:YES completion:nil];
                } else {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Error" description:msg type:TWMessageBarMessageTypeError duration:2];
                }
            });
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self doneTapped:nil];
    return shouldReturn;
}

@end
