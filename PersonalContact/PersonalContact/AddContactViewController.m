//
//  AddContactViewController.m
//  PersonalContact
//
//  Created by Shiina Mashiro on 10/9/15.
//  Copyright © 2015 Shiina Mashiro. All rights reserved.
//

#import "AddContactViewController.h"
#import "Contact.h"

@interface AddContactViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIButton *addContactBtn;


@end


@implementation AddContactViewController

- (IBAction)saveBtnClick {
    // 获取姓名和电话
//    NSString *name = self.nameField.text;
//    NSString *tel = self.telField.text;
    
    // 通知上一个控制器，完成联系人的保存
    
//    if ([self.delegate respondsToSelector:@selector(addContactViewControllerDelegate:didSaveContactWithName:andTel:)]) {
//        [self.delegate addContactViewControllerDelegate:self didSaveContactWithName:name andTel:tel];
//    }
    if ([self.delegate respondsToSelector:@selector(addContactViewControllerDelegate:didSaveContact:)]) {
        Contact *contact = [[Contact alloc] init];
        contact.name = self.nameField.text;
        contact.tel = self.telField.text;
        [self.delegate addContactViewControllerDelegate:self didSaveContact:contact];
    }
    // 上一个控制器就可以刷新表格
}

- (IBAction)textChange {
    self.addContactBtn.enabled = (self.nameField.text.length != 0 && self.telField.text.length != 0);
}

@end
