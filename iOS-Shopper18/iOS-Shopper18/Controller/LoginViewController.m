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
#import "LoginViewModel.h"
#import <TWMessageBarManager.h>

@interface LoginViewController ()

@property (strong, nonatomic) LoginViewModel *vm;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = LoginViewModel.new;
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
    NSArray<NSString *> *errorMsgs = [self validateForm];
    if (!errorMsgs) {
        NSLog(@"%@", [self formValues]);
        [self.vm login:[self formValues] completion:^(BOOL success, NSString * _Nullable msg) {
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

- (IBAction)resetPassTapped:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Forgot your password"
                                                                   message:@"Enter the associated email" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *email = alert.textFields[0].text;
        if (!email || !email.length) return;
        [self.vm resetPass:email completion:^(BOOL success, NSString * _Nullable msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Password reset email sent."
                                                             description:@"" type:TWMessageBarMessageTypeInfo duration:2];
            });
        }];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self signinTapped:nil];
    return shouldReturn;
}


@end
