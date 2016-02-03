//
//  LoginViewController.m
//  PersonalContact
//
//  Created by Shiina Mashiro on 10/8/15.
//  Copyright © 2015 Shiina Mashiro. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactsViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPwdSwitch;

- (IBAction)loginBtnClick;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginBtnClick {
    NSString *account = self.accountField.text;
    NSString *password = self.passwordField.text;
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.labelText = @"基佬祈祷中……";
    [HUD show:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([account isEqualToString:@"zhangsan"] && [password isEqualToString:@"123"]) {
//            NSLog(@"账号与密码正确");
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-right"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText = @"登陆成功";
            [HUD show:YES];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [HUD hide:YES];
                [self performSegueWithIdentifier:@"toContactsSegue" sender:nil];
            });
        } else {
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-error"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText = @"账号或密码错误";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
//            NSLog(@"账号或密码错误");
        }
    });
}

// 使用segue跳转下一个界面之前会调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVC = segue.destinationViewController;
    
    if ([destVC isKindOfClass:[ContactsViewController class]]) {
        ContactsViewController *contactsVC = destVC;
        contactsVC.name = self.accountField.text;
    }
}

- (IBAction)textChange {
    self.loginBtn.enabled = (self.accountField.text.length != 0 && self.passwordField.text.length != 0);
}

- (IBAction)rememberPwdSwitchChange {
    // 如果记住密码为关闭状态，并且自动登录为开启状态，此时自动登录应改为关闭状态
    if (self.rememberPwdSwitch.isOn == NO && self.autoLoginSwitch.isOn == YES) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}
- (IBAction)autoLoginSwitchChange:(id)sender {
    // 如果自动登录为开启状态，并且记住密码为关闭状态，此时记住密码应改为开启状态
    if (self.autoLoginSwitch.isOn == YES && self.rememberPwdSwitch.isOn == NO) {
        [self.rememberPwdSwitch setOn:YES animated:YES];
    }
}

@end
