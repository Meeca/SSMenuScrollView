//
//  MenuControlView.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//


#import "MenuControlView.h"
#import "CustomerScrollViewModel.h"
#import "MenuCollectionCell.h"

@interface MenuControlView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{

    CGRect _frame;

}
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UICollectionView *collectionView;
/// 一页可容纳的最多Item数目
@property (nonatomic,assign) NSInteger numberOfSinglePage;
@end

@implementation MenuControlView


- (instancetype)initWithFrame:(CGRect)frame withmacCol:(NSInteger )maxCol maxRow:(NSInteger )maxRow
{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        _frame = frame;
        self.backgroundColor = [UIColor brownColor];
        _maxRow = maxRow==0?1:maxRow;
        _maxCol = maxCol==0?1:maxCol;
    }
    return self;
}

- (void)setViews
{
    //添加到主视图
    [self addSubview:self.collectionView];
    self.numberOfSinglePage = _maxCol * _maxRow;
    
    NSInteger pageCount = _dataArray.count / self.numberOfSinglePage;
    if (_dataArray.count % self.numberOfSinglePage > 0) {
        pageCount += 1;
    }
    self.pageControl.numberOfPages = pageCount;//指定页面个数
    self.pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    [self addSubview:self.pageControl];
    
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self setViews];
    
    [self.collectionView reloadData];
    
    
    
}

- (void)reloadData{
    [self.collectionView reloadData];
}


#pragma mark - UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionCell *cell =
    [MenuCollectionCell cellWithCollectionView:collectionView
                                    forIndexPath:indexPath];
    CustomerScrollViewModel * model = _dataArray[indexPath.row];
    cell.name  =model.name;
    cell.image  =model.icon;
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = collectionView.frame.size.width/ _maxCol;
    CGFloat height = collectionView.frame.size.height/ _maxRow;
    return CGSizeMake(width, height);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}


- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, _frame.size.height-10, _frame.size.width, 10);
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.backgroundColor = [UIColor blueColor];
    }
    return _pageControl;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //创建容器视图
        CGRect frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height-10);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                              collectionViewLayout:layout];
        _collectionView.delegate = self;//设置代理
        _collectionView.dataSource = self;//设置数据源
        _collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[MenuCollectionCell class]
           forCellWithReuseIdentifier:[MenuCollectionCell cellIdentifier]];

        
    }
    return _collectionView;
}





@end
