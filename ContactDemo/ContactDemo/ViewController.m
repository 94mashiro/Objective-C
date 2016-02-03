//
//  ViewController.m
//  ContactDemo
//
//  Created by Shiina Mashiro on 15/10/12.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"
#import "ContactGroup.h"

@interface ViewController ()<UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_contacts;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
