//
//  MenuScrollView.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "MenuScrollView.h"
#import "CustomerScrollViewModel.h"
//#import "UIButton+WebImage.h"

@interface MenuScrollView ()<UIScrollViewDelegate>{
    CGRect _frame;
}
@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
/// 一页可容纳的最多Item数目
@property (nonatomic,assign) NSInteger numberOfSinglePage;
@end

@implementation MenuScrollView

#pragma mark - getter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
     }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withmacCol:(NSInteger )maxCol maxRow:(NSInteger )maxRow
{
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        _maxRow = maxRow;
        _maxCol = maxCol;
    }
    return self;
}

- (void)setMaxCol:(NSInteger)maxCol{
    _maxCol = maxCol;
}
- (void)setMaxRow:(NSInteger)maxRow{
    _maxRow = maxRow;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    // 初始化
    [self initDataAndSubviews];
}





-(void)initDataAndSubviews{
    
    NSAssert(_maxCol != 0, @"列数不能为0");
    NSAssert(_maxRow != 0, @"行数数不能为0");

    self.numberOfSinglePage = _maxCol * _maxRow;
    
    NSInteger pageCount = self.dataArr.count / self.numberOfSinglePage;
    if (self.dataArr.count % self.numberOfSinglePage > 0) {
        pageCount += 1;
    }
    self.contentScrollView.contentSize = CGSizeMake(_frame.size.width * pageCount, 0);
     for (int i = 0; i < pageCount; i++) {
        [self addViewsWithPageNum:i withCol:_maxCol withMaxRow:_maxRow];
    }
    [self addSubview:self.contentScrollView];
    // 添加pageControl
    self.pageControl.numberOfPages = pageCount;
    [self addSubview:_pageControl];
    [self bringSubviewToFront:_pageControl];

    
}
// 循环添加按钮
-(void)addViewsWithPageNum:(NSInteger)number withCol:(NSInteger )maxCol withMaxRow:(NSInteger )maxRow{
    
    CGFloat btnW =   [[UIScreen mainScreen] bounds].size.width/maxCol;
    CGFloat btnH =  (self.frame.size.height - 20)/maxRow;

    NSInteger count = self.dataArr.count - (number * self.numberOfSinglePage);
    NSInteger indexCount;
    if (count > 0 && count <= self.numberOfSinglePage) {
        indexCount = count;
    }else if(count > self.numberOfSinglePage){
        indexCount = self.numberOfSinglePage;
    }else{
        return;
    }
    for (int i = 0; i<indexCount; i++) {
        int col = i % maxCol;
        int row = i / maxCol;
        NSInteger index = i + number * self.numberOfSinglePage;
        CGFloat btnX =  col * (btnW) + number * _frame.size.width;
        CGFloat btnY =  row * (btnH);
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        [self.contentScrollView addSubview:view];
        [self addSubViewWithView:view withIndex:index];
    }
}

- (void)addSubViewWithView:(UIView *)view withIndex:(NSInteger )index{

    CustomerScrollViewModel * model = _dataArr[index];

    CGFloat itemHeight = view.frame.size.height - 20;
    CGFloat itemWidth = view.frame.size.height;
    CGFloat imageViewSize = MIN(itemHeight, itemWidth);
    
    UIButton * imageBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    imageBtn.frame =CGRectMake(0, 0,imageViewSize , imageViewSize);
    
//    [imageBtn setImageWithUrl:model.icon_small placeholder:[UIImage imageNamed:@"file_icon_hlt"] state:UIControlStateNormal];
    [imageBtn setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    imageBtn.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2 - 10);
    [view addSubview:imageBtn];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 20, view.frame.size.width, 20)];
    titleLable.text = model.name;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:13];
    [view addSubview:titleLable];

    UIButton  * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    btn.tag = index;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];

}

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, self.frame.size.height - 20)];
        _contentScrollView.delegate = self;
        _contentScrollView.backgroundColor =  [UIColor yellowColor];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentScrollView;
}


- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, self.frame.size.height-10, self.frame.size.width, 10);
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.backgroundColor = [UIColor blueColor];
    }
    return _pageControl;
}


- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
// 按钮点击事件
-(void)btnClick:(UIButton *)btn{
    NSLog(@"click:%ld",btn.tag);
    if (_delegate && [_delegate respondsToSelector:@selector(menuScrollViewDeleagte:index:)]) {
        [_delegate menuScrollViewDeleagte:self index:btn.tag];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger correntCount = (scrollView.contentOffset.x + _frame.size.width/2)/_frame.size.width;
    self.pageControl.currentPage = correntCount;
}

@end
