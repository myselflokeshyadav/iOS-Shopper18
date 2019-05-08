//
//  PasswordViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "PasswordViewController.h"
#import "ProfileViewModel.h"
#import "UIViewController+Helpers.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <TWMessageBarManager.h>
#import "User.h"
#import "APIHandler.h"

@interface PasswordViewController () {
    BOOL passwordsMatch;
}

@property (strong, nonatomic) ProfileViewModel *vm;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = ProfileViewModel.new;
    self.navigationItem.title = @"Edit Password";
    passwordsMatch = NO;
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
    [row setOnChangeBlock:^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        XLFormRowDescriptor *passRow = [self.form formRowWithTag:@"newpassword"];
        passwordsMatch = passRow.value && [passRow.value isEqualToString:newValue];
    }];
    
    // Password
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    row = [self passwordRowRequired:YES];
    row.tag = @"newpassword";
    row.title = @"New Password";
    [row setOnChangeBlock:^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        XLFormRowDescriptor *passRow = [self.form formRowWithTag:@"password"];
        passwordsMatch = passRow.value && [passRow.value isEqualToString:newValue];
    }];
    
    [self setReturnKeyForRow:row returnType:UIReturnKeyDone];
    [section addFormRow:row];
    
    self.lastField = [self floatCellForRow:row].floatLabeledTextField;
    self.form = form;
}

- (IBAction)doneTapped:(id)sender {
    [[self.tableView superview] endEditing:YES];
    if (!self.formChanged) {
        [self alert:@"Nothing's changed!" msg:@"Try making some edits first"];
        return;
    }
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs && passwordsMatch) {
        [self.vm changePassword:[self formValues] completion:^(id _Nullable result, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result && [result containsString:@"success"]) {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Success" description:@"Password Updated" type:TWMessageBarMessageTypeSuccess duration:4];
                    self.formChanged = NO;
                } else {
                    [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Error" description:result
                                                                        type:TWMessageBarMessageTypeError duration:4];
                }
            });
        }];
    } else if (!passwordsMatch) {
        [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Error" description:@"Passwords do not match"
                                                            type:TWMessageBarMessageTypeError duration:4];
    }
}

- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue {
    [super formRowDescriptorValueHasChanged:formRow oldValue:oldValue newValue:newValue];
    if (![oldValue isKindOfClass:NSString.class] && ![newValue isKindOfClass:NSString.class]) return;
    if (![oldValue isKindOfClass:NSString.class] || ![newValue isKindOfClass:NSString.class]) {
        self.formChanged = YES;
        return;
    }
    BOOL changed = ![(NSString *)oldValue isEqualToString:newValue];
    self.formChanged = self.formChanged || changed;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self doneTapped:nil];
    return shouldReturn;
}
@end
