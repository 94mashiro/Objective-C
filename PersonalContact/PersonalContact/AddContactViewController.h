//
//  AddContactViewController.h
//  PersonalContact
//
//  Created by Shiina Mashiro on 10/9/15.
//  Copyright © 2015 Shiina Mashiro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddContactViewController, Contact;

@protocol AddContactViewControllerDelegate <NSObject>

@optional
- (void)addContactViewControllerDelegate:(AddContactViewController *)addContactVc didSaveContactWithName:(NSString *)name andTel:(NSString *)tel;

// 直接返回一个联系人模型
- (void)addContactViewControllerDelegate:(AddContactViewController *)addContactVc didSaveContact:(Contact *)contact;

@end

@interface AddContactViewController : UIViewController

@property (weak, nonatomic) id<AddContactViewControllerDelegate> delegate;

@end
