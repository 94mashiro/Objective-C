//
//  ImageStore.h
//  Homepwner
//
//  Created by Shiina Mashiro on 16/2/7.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@interface ImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
