//
//  ItemStore.m
//  Homepwner
//
//  Created by Shiina Mashiro on 16/2/1.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ItemStore

+ (instancetype)sharedStore {
    static ItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ItemStore shareStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item {
    // removeObjectIdenticalTo: Removes all occurrences of a given object in the array.
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    // 获取要移动的对象的指针
    BNRItem *item = self.privateItems[fromIndex];
    // 在allItems数组中移除item
    [self.privateItems removeObjectAtIndex:fromIndex];
    // 将item以新索引位置插入allItems数组中，完成对item在数组中的移动
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
