
//
//  MenuScrollViewController.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "MenuScrollViewController.h"
#import "MenuScrollView.h"
#import "MenuControlView.h"

#import "CustomerScrollViewModel.h"

@interface MenuScrollViewController ()<MenuScrollViewDeleagte>{

    NSInteger _row;
    NSInteger _col;

}
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (nonatomic,strong) MenuScrollView * menuScrollView;
@property(strong , nonatomic)MenuControlView *pageControlV;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation MenuScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    
    self.tabelView.tableHeaderView  = self.menuScrollView;
    self.tabelView.tableFooterView  = self.pageControlV;

    
    for (int i=0; i<37; i++) {
        CustomerScrollViewModel * model = [[CustomerScrollViewModel alloc ] init];
        NSInteger index = arc4random()%10;
        model.name = [NSString stringWithFormat:@"标题%d",i];
        model.icon = [NSString stringWithFormat:@"6090%ld.png",index];
        [_dataArray addObject:model];
    }
    self.menuScrollView.dataArr = _dataArray;
    
    _col = 2;
    _row = 3;
    
    self.pageControlV.dataArray = _dataArray;
    
    // Do any additional setup after loading the view from its nib.
}

-(MenuScrollView *)menuScrollView{
    if (!_menuScrollView) {
        _menuScrollView = [[MenuScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 225)];
        _menuScrollView.maxCol  =  4;
        _menuScrollView.maxRow = 3;
        _menuScrollView.delegate = self;
    }
    return _menuScrollView;
}
- (MenuControlView *)pageControlV
{
    if (!_pageControlV) {
        _pageControlV = [[MenuControlView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 252) withmacCol:3 maxRow:2];
    }
    return _pageControlV;
}

#pragma mark - CustomerScrollViewDeleagte

- (void)menuScrollViewDeleagte:(id)menuScrollViewDeleagte index:(NSInteger)index{
    NSLog(@"点击的是 第%ld个",index);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
