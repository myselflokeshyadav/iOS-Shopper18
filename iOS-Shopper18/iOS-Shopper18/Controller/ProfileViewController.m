//
//  ProfileViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileViewModel.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <TWMessageBarManager.h>

@interface ProfileViewController ()

@property (strong, nonatomic) ProfileViewModel *vm;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = ProfileViewModel.new;
    self.navigationItem.title = @"Profile";
}

- (void)initializeForm
{
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    // First name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self fnameRowRequired:NO];
    [section addFormRow:row];
    
    // Last name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self lnameRowRequired:NO];
    [section addFormRow:row];
    
    // Address
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self addressRowRequired:NO];
    [section addFormRow:row];
    
    // Mobile
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self mobileRowRequired:NO];
    [section addFormRow:row];
    
    // Email
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self emailRowRequired:NO];
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)doneTapped:(id)sender {
    [[self.tableView superview] endEditing:YES];
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs) {
        [self.vm updateProfile:[self formValues] completion:^(id _Nullable result, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Success" description:@"Profile Updated" type:TWMessageBarMessageTypeSuccess duration:2];
                } else {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Error" description:@"Mobile number not found"
                                                                        type:TWMessageBarMessageTypeError duration:2];
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

