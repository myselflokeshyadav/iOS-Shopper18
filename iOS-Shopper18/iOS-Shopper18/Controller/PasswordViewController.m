//
//  PasswordViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "PasswordViewController.h"
#import "ProfileViewModel.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <TWMessageBarManager.h>
#import "User.h"
#import "APIHandler.h"

@interface PasswordViewController ()

@property (strong, nonatomic) ProfileViewModel *vm;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = ProfileViewModel.new;
    self.navigationItem.title = @"Edit Password";
}

- (void)initializeForm
{
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    // Email
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self emailRowRequired:YES];
    row.value = APIHandler.shared.currentUser.email;
    [section addFormRow:row];
    
    // Password
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self passwordRowRequired:YES];
    row.tag = @"password";
    row.title = @"Old Password";
    [section addFormRow:row];
    
    // Password
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self passwordRowRequired:YES];
    row.tag = @"newpassword";
    row.title = @"New Password";
    [row setOnChangeBlock:^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        XLFormRowDescriptor *passRow = [self.form formRowWithTag:@"password"];
        if (passRow.value && [passRow.value isEqualToString:newValue]) return;
        UITableViewCell *cell = [self tableCellForRow:passRow];
        [self shakeCell:cell];
    }];
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)doneTapped:(id)sender {
    [[self.tableView superview] endEditing:YES];
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs) {
        [self.vm changePassword:[self formValues] completion:^(id _Nullable result, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([result containsString:@"success"]) {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Success" description:@"Password Updated" type:TWMessageBarMessageTypeSuccess duration:2];
                } else {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Error" description:result
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
