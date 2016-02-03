//
//  ContentCell.h
//  DialogViewer
//
//  Created by Shiina Mashiro on 10/5/15.
//  Copyright © 2015 Shiina Mashiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) NSString *text;

+ (CGSize)sizeForContentString:(NSString *)s;

@end
