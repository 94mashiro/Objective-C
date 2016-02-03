//
//  EditContactViewController.m
//  PersonalContact
//
//  Created by Shiina Mashiro on 15/10/10.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"
@interface EditContactViewController()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置文本默认框的默认值
    self.nameField.text = self.contact.name;
    self.telField.text = self.contact.tel;
}
- (IBAction)editBtnClick:(UIBarButtonItem *)item {
    
    // 1.如果当前是不可用的状态 设置文本输入框为可用 按钮可见
    self.nameField.enabled = !self.nameField.enabled;
    self.telField.enabled = !self.telField.enabled;
    self.saveBtn.hidden = !self.saveBtn.hidden;
    // 2.改变“编辑”按钮的文字
    if (self.nameField.enabled) {
        item.title = @"取消";
    } else {
        item.title = @"编辑";
    }
}
- (IBAction)saveBtnClick:(id)sender {
    // 通过代理通知上一个控制器“完成”联系人的编辑
    if ([self.delegate respondsToSelector:@selector(editContactViewController:didFinishSaveContact:)]) {
        // 更改联系人模型
        self.contact.name = self.nameField.text;
        self.contact.tel = self.telField.text;
        
        // 调用代理
        [self.delegate editContactViewController:self didFinishSaveContact:self.contact];
    }
}

- (IBAction)textChange {
    self.saveBtn.enabled = (self.nameField.text.length != 0 && self.telField.text.length != 0);
}

@end
