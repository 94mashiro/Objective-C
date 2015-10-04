//
//  FavoritesList.h
//  Fonts
//
//  Created by Shiina Mashiro on 15/10/4.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;

- (void)removeFavorite:(id)item;

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@property (strong, nonatomic) NSMutableArray *favorites;

@end
