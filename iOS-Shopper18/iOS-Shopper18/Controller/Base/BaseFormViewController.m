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

- (void)setTagForRow:(XLFormRowDescriptor *)row tag:(NSInteger)tag {
    FloatLabeledTextFieldCell *cell = [self floatCellForRow:row];
    cell.floatLabeledTextField.tag = tag;
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
