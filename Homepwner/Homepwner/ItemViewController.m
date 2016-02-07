//
//  ItemViewController.m
//  Homepwner
//
//  Created by Shiina Mashiro on 16/1/31.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import "ItemViewController.h"
#import "DetailViewController.h"
#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemViewController ()

// 已不需要
//@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // 注册UITableViewCell，以便重用
//    UIView *header = self.headerView;
    // 将header这个view设置为Table的HeaderView
//    [self.tableView setTableHeaderView:header];
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        // UINavigationItem: A UINavigationItem object manages the buttons and views to be displayed in a UINavigationBar object.
        
        // UINavigationItem.title: The navigation item’s title displayed in the center of the navigation bar.
        navItem.title = @"Homepwner";
        
        // 下面就要设置两个NavBar的按钮
        // 首先是右边的加号按钮，触发的方法是添加新表格行
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        // 将右侧指向新创建的加号按钮
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}


// NSInteger: When building 32-bit applications, NSInteger is a 32-bit integer. A 64-bit application treats NSInteger as a 64-bit integer9.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
//    if (indexPath.row ==[[[ItemStore sharedStore] allItems] count]) {
//        cell.textLabel.text = @"No more items!";
//        return cell;
//    }
    
    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}



- (IBAction)addNewItem:(id)sender {
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[ItemStore sharedStore] createItem];
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    // 不用之前的numberOfRowsInSection来找最后一列是因为这样做并不会改变allItem数组，这样UITableView获取显示的行数的时候还是原来的5行，所以会产生冲突而报错。
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

//- (IBAction)toggleEditingMode:(id)sender {
//    if (self.isEditing) {
//        // 修改按钮文字，提示用户当前的状态
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        // 关闭编辑模式
//        [self setEditing:NO animated:YES];
//    } else {
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}

//- (UIView *)headerView {
//    // 延迟实例化 (lazy instantitation)
//    if (!_headerView) {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}


// 实现删除行功能

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 判断UITableView请求的是不是删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        // 还需要删除TableView中相应的Row
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// 实现移动行的数据源协议方法，移动行只需为数据源实现tableView:moveRowAtIndexPath:toIndexPath方法即可
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 首先要实现数组中移动元素的方法
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    // 一旦实现了这个方法，UITableView则会自动显示换位的控件，反之则不会
//    if (destinationIndexPath.row == [[[ItemStore sharedStore] allItems] count]) {
//        return;
//    } else {
//        [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
//    }
//    
}



// Bronze Challenge: 将"Delete"的按钮的标题改为"Remove"
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}


// Silver Challenge: 始终在最后一行显示标题为"No more items!"的UITableViewCell对象，并且禁止该表格行移动
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == [[[ItemStore sharedStore] allItems] count]) {
//        return NO;
//    } else {
//        return YES;
//    }
//}


// Gold Challenge: 使No more items始终保持在表格视图的底部
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
//    if (sourceIndexPath.row == proposedDestinationIndexPath.row) {
//        return sourceIndexPath;
//    } else {
//        if (proposedDestinationIndexPath.row == [[[ItemStore sharedStore] allItems] count]) {
//            return sourceIndexPath;
//        } else {
//            return proposedDestinationIndexPath;
//        }
//    }
//}


// 开始第十章的内容
// 切换视图并且将数据传入
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    // 在视图转换之前将DetailViewController的item属性赋值
    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *selectItem = items[indexPath.row];
    detailViewController.item = selectItem;
    // 将detailViewController压入UINavigationController的栈
    [self.navigationController pushViewController:detailViewController animated:YES];
}

// 刷新视图
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


@end
