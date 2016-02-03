//
//  EditContactViewController.h
//  PersonalContact
//
//  Created by Shiina Mashiro on 15/10/10.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact, EditContactViewController;

@protocol EditContactViewControllerDelegate <NSObject>

- (void)editContactViewController:(EditContactViewController *)editContectVc didFinishSaveContact:(Contact *)contact;

@end

@interface EditContactViewController : UIViewController

@property (nonatomic, strong) Contact *contact;
@property (weak, nonatomic) id<EditContactViewControllerDelegate> delegate;

@end
