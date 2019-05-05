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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.clipsToBounds = NO;
}

#pragma MARK: - Row constructors

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
    [self floatCellForRow:row].floatLabeledTextField.secureTextEntry = YES;
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:@"^.{6,32}$"]];
    return row;
}

- (XLFormRowDescriptor *)emailRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"email" title:@"Email"];
    row.required = required;
    [self floatCellForRow:row].floatLabeledTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self floatCellForRow:row].floatLabeledTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [row addValidator:[XLFormValidator emailValidator]];
    return row;
}

- (XLFormRowDescriptor *)fnameRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"fname" title:@"First Name"];
    row.required = required;
    [self setInputOptionForRow:row option:InputLettersOnly];
    [self floatCellForRow:row].floatLabeledTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self floatCellForRow:row].floatLabeledTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    return row;
}

- (XLFormRowDescriptor *)lnameRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"lname" title:@"Last Name"];
    row.required = required;
    [self setInputOptionForRow:row option:InputLettersOnly];
    [self floatCellForRow:row].floatLabeledTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self floatCellForRow:row].floatLabeledTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    return row;
}

- (XLFormRowDescriptor *)addressRowRequired:(BOOL)required {
    XLFormRowDescriptor *row = [self floatRowWithTag:@"address" title:@"Address"];
    row.required = required;
    [self floatCellForRow:row].floatLabeledTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self floatCellForRow:row].floatLabeledTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    return row;
}

#pragma MARK: - Cell animations

- (UITableViewCell *)tableCellForRow:(XLFormRowDescriptor *)row {
    return [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:row]];
}

- (void)flashCell:(UITableViewCell *)cell color:(UIColor *)color {
    cell.backgroundColor = color;
    [UIView animateWithDuration:0.3 animations:^{
        cell.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)shakeCell:(UITableViewCell *)cell
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values =  @[ @0, @20, @-20, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.additive = YES;
    
    [cell.layer addAnimation:animation forKey:@"shake"];
}

#pragma MARK: - Form Helpers

- (nullable NSArray<NSString *> *)validateForm {
    NSArray *errors = [self formValidationErrors];
    if (!errors.count) return nil;
    NSMutableArray *msgs = NSMutableArray.new;
    for (id obj in errors) {
        XLFormValidationStatus * validationStatus = [[obj userInfo] objectForKey:XLValidationStatusErrorKey];
        UITableViewCell * cell = [self floatCellForRow:validationStatus.rowDescriptor];
        [msgs addObject:validationStatus.msg];
//        [self flashCell:cell color:UIColor.orangeColor];
        [self shakeCell:cell];
    }
    NSLog(@"%@", [msgs componentsJoinedByString:@"\n"]);
    return msgs;
}


#pragma MARK: - Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string.length) return YES;
    switch (textField.tag) {
        case InputLettersOnly:
            if ([string isEqualToString:@" "]) return YES;
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
