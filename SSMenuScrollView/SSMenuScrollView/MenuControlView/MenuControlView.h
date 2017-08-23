//
//  MenuControlView.h
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MenuControlView : UIView
- (instancetype)initWithFrame:(CGRect)frame withmacCol:(NSInteger )maxCol maxRow:(NSInteger )maxRow;

@property (nonatomic,assign) NSInteger maxCol; // 列
@property (nonatomic,assign) NSInteger maxRow; // 行

@property (strong, nonatomic) NSArray *dataArray;
- (void)reloadData;

@end
