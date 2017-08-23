//
//  MenuCollectionCell.h
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface MenuCollectionCell : UICollectionViewCell

@property (strong, nonatomic) NSString  *image;
@property (strong, nonatomic) NSString *name;

/* 方块视图的缓存池标示 */
+ (NSString *)cellIdentifier;
/* 获取方块视图对象 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                          forIndexPath:(NSIndexPath *)indexPath;

@end
