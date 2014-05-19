//
//  TabBarViewController.m
//  FirstProject
//
//  Created by 传晟 on 14-5-18.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainViewController.h"
#import "LiveViewController.h"
#import "ShoppingCarViewController.h"
#import "MyGoodsViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UITabBarItem *imageViewItem1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"heart_stroke_24x21"] tag:10];
    [mainVC setTabBarItem:imageViewItem1];
    UINavigationController *mainNVC = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    LiveViewController *liveVC = [[LiveViewController alloc]init];
    UITabBarItem *imageViewItem2 = [[UITabBarItem alloc]initWithTitle:@"生活" image:[UIImage imageNamed:@"heart_stroke_24x21"] tag:11];
    [liveVC setTabBarItem:imageViewItem2];
    UINavigationController *liveNVC = [[UINavigationController alloc]initWithRootViewController:liveVC];
    
    ShoppingCarViewController *shopVC = [[ShoppingCarViewController alloc]init];
    UITabBarItem *imageViewItem3 = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"heart_stroke_24x21"] tag:11];
    [shopVC setTabBarItem:imageViewItem3];
    UINavigationController *shopCarNVC = [[UINavigationController alloc]initWithRootViewController:shopVC];
    
    MyGoodsViewController *goodsVC = [[MyGoodsViewController alloc]init];
    UITabBarItem *imageViewItem4 = [[UITabBarItem alloc]initWithTitle:@"我的淘宝" image:[UIImage imageNamed:@"heart_stroke_24x21"] tag:11];
    [goodsVC setTabBarItem:imageViewItem4];
    UINavigationController *goodsNVC = [[UINavigationController alloc]initWithRootViewController:goodsVC];
    
    NSArray *items = @[mainNVC,liveNVC,shopCarNVC,goodsNVC];
    
    [self setViewControllers:items animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
