//
//  FontListViewController.h
//  Fonts
//
//  Created by Shiina Mashiro on 15/10/5.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListViewController : UITableViewController

@property (copy, nonatomic) NSArray *fontNames;
@property (assign, nonatomic) BOOL showsFavorites;

@end
