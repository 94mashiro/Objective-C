//
//  ContactsViewController.m
//  PersonalContact
//
//  Created by Shiina Mashiro on 10/8/15.
//  Copyright © 2015 Shiina Mashiro. All rights reserved.
//

#import "ContactsViewController.h"
#import "AddContactViewController.h"
#import "Contact.h"
#import "EditContactViewController.h"

@interface ContactsViewController ()<AddContactViewControllerDelegate, EditContactViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (NSMutableArray *)contacts {
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@的联系人",self.name];
}

#pragma mark 表格的数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 显示数据
    Contact *contact = self.contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.tel;
    
    return cell;
}

- (IBAction)logoutBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 获取目标控制器
    id destVc = segue.destinationViewController;
    // 判断类型
    if ([destVc isKindOfClass:[AddContactViewController class]]) {
        AddContactViewController *addContactVc = destVc;
        addContactVc.delegate = self;
    } else if ([destVc isKindOfClass:[EditContactViewController class]]) {
        // 1.获取目标控制器
        EditContactViewController *editVc = destVc;
        // 2.获取对应索引的联系人
        NSInteger selectedRow = self.tableView.indexPathForSelectedRow.row;
        Contact *contact = self.contacts[selectedRow];
        // 3.设计编辑联系人的控制器的contact属性
        editVc.contact = contact;
        
        // 4.设置编辑联系人的代理
        editVc.delegate = self;
    }
}

//- (void)addContactViewControllerDelegate:(AddContactViewController *)addContactVc didSaveContactWithName:(NSString *)name andTel:(NSString *)tel {
//    Contact *contact = [[Contact alloc] init];
//    contact.name = name;
//    contact.tel = tel;
//    // 添加联系人数组
//    [self.contacts addObject:contact];
//    // 刷新表格
//    [self.tableView reloadData];
//    // 隐藏添加联系人的控制器
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark 添加联系人控制器的代理
- (void)addContactViewControllerDelegate:(AddContactViewController *)addContactVc didSaveContact:(Contact *)contact {
    //  把模型添加到联系人数组
    [self.contacts addObject:contact];
    // 刷新表格 (**全局刷新性能低下，不推荐**)
//    [self.tableView reloadData];
    // 局部刷新 (**提高性能**)
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.contacts.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[lastPath] withRowAnimation:UITableViewRowAnimationFade];
    // 隐藏添加联系人的控制器
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 编辑联系人控制器的代理

- (void)editContactViewController:(EditContactViewController *)editContectVc didFinishSaveContact:(Contact *)contact {
    // 隐藏编辑联系人的控制器
    [self.navigationController popViewControllerAnimated:YES];
    // 局部刷新数据
    
    //获取当前刷新的行
    NSInteger row = [self.contacts indexOfObject:contact];
    NSIndexPath *refreshIndex = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[refreshIndex] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

@end
