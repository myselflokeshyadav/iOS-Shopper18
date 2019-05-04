//
//  BaseFormViewController.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "XLFormViewController.h"
@class FloatLabeledTextFieldCell;

NS_ASSUME_NONNULL_BEGIN

@interface BaseFormViewController : XLFormViewController
- (FloatLabeledTextFieldCell *)floatCellForRow:(XLFormRowDescriptor *)row;

- (void)setKeyboardForRow:(XLFormRowDescriptor *)row keyboardType:(UIKeyboardType)type;

- (void)setTagForRow:(XLFormRowDescriptor *)row tag:(NSInteger)tag;

- (XLFormRowDescriptor *)floatRowWithTag:(NSString *)tag title:(NSString *)title;

- (XLFormRowDescriptor *)mobileRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)passwordRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)emailRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)fnameRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)lnameRowRequired:(BOOL)required;

- (XLFormRowDescriptor *)addressRowRequired:(BOOL)required;

@end

NS_ASSUME_NONNULL_END
