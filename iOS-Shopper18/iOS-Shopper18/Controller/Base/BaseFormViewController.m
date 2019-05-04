//
//  BaseFormViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "BaseFormViewController.h"
#import "FloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "XLForm.h"

@implementation BaseFormViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm {}

- (FloatLabeledTextFieldCell *)floatCellForRow:(XLFormRowDescriptor *)row {
    return (FloatLabeledTextFieldCell *)[row cellForFormController:self];
}

- (void)setKeyboardForRow:(XLFormRowDescriptor *)row keyboardType:(UIKeyboardType)type{
    FloatLabeledTextFieldCell *cell = [self floatCellForRow:row];
    cell.floatLabeledTextField.keyboardType = type;
}

- (void)setInputOptionForRow:(XLFormRowDescriptor *)row option:(FormInputOption)option {
    FloatLabeledTextFieldCell *cell = [self floatCellForRow:row];
    cell.floatLabeledTextField.tag = option;
}

- (XLFormRowDescriptor *)floatRowWithTag:(NSString *)tag title:(NSString *)title {
    return [XLFormRowDescriptor formRowDescriptorWithTag:tag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:title];
}

- (XLFormRowDescriptor *)mobileRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"mobile" title:@"Mobile"];
    row.required = required;
    [row.cellConfigAtConfigure setObject:@10 forKey:@"textFieldMaxNumberOfCharacters"];
    [self setKeyboardForRow:row keyboardType:UIKeyboardTypePhonePad];
    [self setInputOptionForRow:row option:InputNumbersOnly];
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"Not a valid phone number"
                                                                regex:@"^\\d{10}$"]];
    return row;
}

- (XLFormRowDescriptor *)passwordRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"password" title:@"Password"];
    row.required = required;
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:@"^(?=.*\\d)(?=.*[A-Za-z]).{6,32}$"]];
    return row;
}

- (XLFormRowDescriptor *)emailRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"email" title:@"Email"];
    row.required = required;
    [row addValidator:[XLFormValidator emailValidator]];
    return row;
}

- (XLFormRowDescriptor *)fnameRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"fname" title:@"First Name"];
    [self setInputOptionForRow:row option:InputLettersOnly];
    row.required = required;
    return row;
}

- (XLFormRowDescriptor *)lnameRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"lname" title:@"Last Name"];
    [self setInputOptionForRow:row option:InputLettersOnly];
    row.required = required;
    return row;
}

- (XLFormRowDescriptor *)addressRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"address" title:@"Address"];
    row.required = required;
    return row;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string.length) return YES;
    switch (textField.tag) {
        case InputLettersOnly:
            return [NSCharacterSet.letterCharacterSet characterIsMember:[string characterAtIndex:0]];
        case InputNumbersOnly:
            return [NSCharacterSet.decimalDigitCharacterSet characterIsMember:[string characterAtIndex:0]];
        default:
            return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return UIView.new;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}
@end
