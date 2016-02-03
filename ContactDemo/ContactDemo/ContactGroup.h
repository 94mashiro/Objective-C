//
//  ContactGroup.h
//  ContactDemo
//
//  Created by Shiina Mashiro on 15/10/12.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactGroup : NSObject

#pragma mark 组名
@property (nonatomic, copy) NSString *name;

#pragma mark 分组描述
@property (nonatomic, copy) NSString *detail;

#pragma mark 联系人
@property (nonatomic, strong) NSMutableArray *contacts;

#pragma mark 带参数的构造函数
-(ContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

#pragma mark 静态初始化方法
+(ContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

@end
