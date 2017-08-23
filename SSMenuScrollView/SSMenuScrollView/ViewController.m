//
//  ViewController.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "ViewController.h"
#import "MenuScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)MenuScrollViewControllerAction:(id)sender {
    
    MenuScrollViewController * vc = [[MenuScrollViewController alloc] initWithNibName:@"MenuScrollViewController" bundle:nil];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
