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

#import "RegisterViewController.h"


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
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    UITabBarItem *imageViewItem5 = [[UITabBarItem alloc]initWithTitle:@"登陆" image:[UIImage imageNamed:@"heart_stroke_24x21"] tag:11];
    [registerViewController setTabBarItem:imageViewItem5];

    NSArray *items = @[mainNVC,liveNVC,shopCarNVC,goodsNVC,registerViewController];
    
    self.delegate = self;
    [self setViewControllers:items animated:YES];
    UITapGestureRecognizer *lTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UIImageView *lImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x_alt_32x32"]];
    lImageView.frame = CGRectMake(260, 460, 40, 40);
    lImageView.alpha = 0.6;
    [lImageView addGestureRecognizer:lTapGesture];
    lImageView.userInteractionEnabled = YES;
    [self.view addSubview:lImageView];

}

-(void)tapClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//UITabBarContrller的代理设置，当点击选择不同的ViewController 时执行
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    
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
