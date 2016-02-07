//
//  DetailViewController.m
//  Homepwner
//
//  Created by Shiina Mashiro on 16/2/4.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    // BRONZE CHALLENGE - DISPLAY A NUMBERPAD FOR THE VALUE FIELD
    self.valueField.keyboardType = UIKeyboardTypeNumberPad;
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 取消当前的第一响应对象，可以代替resignFirstResponder
    [self.view endEditing:YES];
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item {
    // 不能在init方法中设置标题的原因是，这时候item属性还没有赋值，是nil
    _item = item;
    self.navigationItem.title = _item.itemName;
}
// SILVER CHALLENGE - DISMISSING A NUMBER PAD
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
