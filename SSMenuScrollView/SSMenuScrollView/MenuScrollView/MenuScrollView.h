//
//  MenuScrollView.h
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MenuScrollView;
@protocol MenuScrollViewDeleagte <NSObject>


@optional


@required

- (void)menuScrollViewDeleagte:(MenuScrollView *)menuScrollViewDeleagte index:(NSInteger )index;

@end

@interface MenuScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame withmacCol:(NSInteger )maxCol maxRow:(NSInteger )maxRow;

@property (nonatomic,assign) NSInteger maxCol; // 列
@property (nonatomic,assign) NSInteger maxRow; // 行


/// 按钮数据源
@property (nonatomic,strong) NSArray * dataArr;

@property (nonatomic,assign) id<MenuScrollViewDeleagte> delegate;


@end
