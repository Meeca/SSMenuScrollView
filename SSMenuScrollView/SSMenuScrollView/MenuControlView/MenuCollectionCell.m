//
//  MenuCollectionCell.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//


#import "MenuCollectionCell.h"

@interface MenuCollectionCell ()

@property (strong, nonatomic) UIButton *imageBtn;
@property (strong, nonatomic) UILabel  * titleLable;

@end

@implementation MenuCollectionCell

+ (NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"CollectionViewCellIdentifier";
    return cellIdentifier;
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                          forIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:[MenuCollectionCell cellIdentifier]
                                              forIndexPath:indexPath];
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        CGFloat itemHeight = frame.size.height - 20;
        CGFloat itemWidth = frame.size.height;
        CGFloat imageViewSize = MIN(itemHeight, itemWidth);
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
        _imageBtn.frame =CGRectMake(0, 0,imageViewSize , imageViewSize);
        _imageBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 10);
        [self.contentView addSubview:_imageBtn];
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont systemFontOfSize:13];
        [self.contentView  addSubview:_titleLable];
    
    }
    return self;
}

- (void)setImage:(NSString *)image{

    [_imageBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //    [imageBtn setImageWithUrl:model.icon_small placeholder:[UIImage imageNamed:@"file_icon_hlt"] state:UIControlStateNormal];

}

- (void)setName:(NSString *)name{

    _titleLable.text = name;

}

@end
