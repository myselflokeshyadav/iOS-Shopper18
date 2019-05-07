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
@property (strong, nonatomic) UIAlertController *alert;

@end

@implementation LoginViewController


NSString const *emailRegex = kRegexEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vm = LoginViewModel.new;
    self.navigationItem.title = @"Ready to shop?";
    [self setupEmailInput];
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

- (void)setupEmailInput {
    __weak LoginViewController *weakself = self;
    
    self.alert = [UIAlertController alertControllerWithTitle:@"Forgot your password?"
                                                                   message:@"Enter the associated email" preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email";
        textField.delegate = weakself;
    }];
    
    [self.alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        weakself.alert.textFields[0].text = @"";
    }]];
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *email = weakself.alert.textFields[0].text;
        if (!email || !email.length) return;
        [weakself.vm resetPass:email completion:^(BOOL success, NSString * _Nullable msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.alert.textFields[0].text = @"";
                [TWMessageBarManager.sharedInstance showMessageWithTitle:@"Password reset email sent."
                                                             description:@"" type:TWMessageBarMessageTypeInfo duration:2];
            });
        }];
    }];
    
    okAction.enabled = NO;
    [self.alert addAction:okAction];
}

- (IBAction)resetPassTapped:(id)sender {
    [self presentViewController:self.alert animated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = [super textFieldShouldReturn:textField];
    if (shouldReturn && textField == self.lastField)
        [self signinTapped:nil];
    return shouldReturn;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField != self.alert.textFields[0]) return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    string = [textField.text stringByAppendingString:string];
    BOOL isValid = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex] evaluateWithObject:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    self.alert.actions[1].enabled = isValid;
    
    return YES;
    
}

@end
