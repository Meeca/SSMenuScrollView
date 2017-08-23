# SSMenuScrollView
横向滚动的菜单栏（ScrollView 和 UICollectionView）两种实现方式




![Alt text](./4.gif)
![Alt text](./3.gif)

调用方法

```
-(MenuScrollView *)menuScrollView{
if (!_menuScrollView) {
_menuScrollView = [[MenuScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 225)];
_menuScrollView.maxCol  =  4;
_menuScrollView.maxRow = 3;
_menuScrollView.delegate = self;
}
return _menuScrollView;
}
```

```
- (MenuControlView *)pageControlV
{
if (!_pageControlV) {
_pageControlV = [[MenuControlView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 252) withmacCol:3 maxRow:2];
}
return _pageControlV;
}
```

```
#pragma mark - CustomerScrollViewDeleagte

- (void)menuScrollViewDeleagte:(id)menuScrollViewDeleagte index:(NSInteger)index{
NSLog(@"点击的是 第%ld个",index);
}

```
