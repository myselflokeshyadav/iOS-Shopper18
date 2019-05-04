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

@end

NS_ASSUME_NONNULL_END
