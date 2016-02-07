//
//  ItemStore.h
//  Homepwner
//
//  Created by Shiina Mashiro on 16/2/1.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
@end
