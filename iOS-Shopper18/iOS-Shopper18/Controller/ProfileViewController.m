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
#import "APIHandler.h"
#import "User.h"

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
    
    User *user = APIHandler.shared.currentUser;
    
    // First name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self fnameRowRequired:YES];
    row.value = user.fname;
    [section addFormRow:row];
    
    // Last name
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self lnameRowRequired:YES];
    row.value = user.lname;
    [section addFormRow:row];
    
    // Address
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self addressRowRequired:NO];
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

