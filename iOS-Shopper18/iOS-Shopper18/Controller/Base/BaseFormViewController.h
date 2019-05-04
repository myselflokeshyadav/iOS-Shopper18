//
//  BaseFormViewController.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "XLFormViewController.h"
@class FloatLabeledTextFieldCell;
@class JVFloatLabeledTextField;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    InputAnything = 0,
    InputLettersOnly = 1000,
    InputNumbersOnly = 2000,
} FormInputOption;

@interface BaseFormViewController : XLFormViewController
@property (weak, nonatomic, nullable) UITextField *lastField;

- (FloatLabeledTextFieldCell *)floatCellForRow:(XLFormRowDescriptor *)row;

- (void)setKeyboardForRow:(XLFormRowDescriptor *)row keyboardType:(UIKeyboardType)type;

- (void)setInputOptionForRow:(XLFormRowDescriptor *)row option:(FormInputOption)option;

- (XLFormRowDescriptor *)floatRowWithTag:(NSString *)tag title:(NSString *)title;

- (XLFormRowDescriptor *)mobileRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)passwordRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)emailRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)fnameRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)lnameRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)addressRowRequired:(BOOL)required;

- (void)flashCell:(UITableViewCell *)cell color:(UIColor *)color;

- (void)shakeCell:(UITableViewCell *)cell;

- (BOOL)isFormValid;

@end

NS_ASSUME_NONNULL_END
