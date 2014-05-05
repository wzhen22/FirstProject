//
//  FirstViewController.m
//  FirstProject
//
//  Created by 传晟 on 14-5-4.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "FirstViewController.h"
#import "WCustomTableView.h"
#import "BaseCellMember.h"
#import "HeaderAndFooterRefresh.h"
#import "customButton.h"

@interface FirstViewController ()

@end
#define keyForRowData @"rowItems"
#define keyForSectionName @"sectionName"
#define BackName1 @"4.png"
#define BackName2 @"3.png"
@implementation FirstViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    NSString *lstring = [[NSBundle mainBundle] resourcePath];
    NSString *path = [lstring stringByAppendingPathComponent:@"firstViewController.json"];
    NSData *ldata = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];
    
    int rows = [[lDictionary objectForKey:@"rowsOfType"] intValue];//纪录json描绘的有多少行
    for (int i= 0; i<rows; i++) {
        NSString *keyOfGroupItems = [NSString stringWithFormat:@"itemsOfGroup_%d",i];
        NSDictionary *lDic = [lDictionary objectForKey:keyOfGroupItems];
        [dynamicLayout loadItemsForGroup:lDic AndBaseView:self.view];
    }
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典----返回所有控件的tag值与类型的字典
    NSLog(@"***************%@",ldic);
    NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:cArray];//执行响应的响应事件
    
    NSArray *tabelViewArray = [dynamicLayout instanceCustomTabelViewFromDic:ldic AndSupperView:self.view];
    [self customTableViewClick:tabelViewArray];
    
    
}
#pragma mark 自定义按钮控件的响应时间描述
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    //        [cB performSelector:@selector(buttonClick:)];
                    if (cB.clickOfType == 1) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    if (cB.clickOfType == 2)  {
                        NSLog(@"第二种响应类型");
                    }
                    if (cB.clickOfType == 3) {
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"warning" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                        [alertView show];
                        NSLog(@"%ld",(long)alertView.cancelButtonIndex);
                        NSLog(@"%ld",(long)alertView.firstOtherButtonIndex);
                    }
                    if (cB.clickOfType == 4)  {
                        UIImage *image1 = [UIImage imageNamed:BackName1];
                        UIImage *image2 = [UIImage imageNamed:BackName2];
                        if ([[cB backgroundImageForState:UIControlStateNormal]isEqual:image2]) {
                            [cB setBackgroundImage:image1 forState:UIControlStateNormal];
                        }else{
                            [cB setBackgroundImage:image2 forState:UIControlStateNormal];
                        }
                    }
                    NSLog(@"____________________");
                };
                
            }
        }
        
    }
}
-(void)customTableViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]){
                WCustomTableView *cTableView = [array objectAtIndex:i];
                [self addHeaderWithTableView:cTableView];
            }
        }
    }
}
#pragma mark 表视图的头部刷新控件关联
//在此进行重载数据
- (void)addHeaderWithTableView:(WCustomTableView *)cTableView
{
    RefreshHeaderView *headerView = [RefreshHeaderView header];
    headerView.scrollView  = cTableView;
    __block WCustomTableView *tableViewC = cTableView;
    headerView.beginBolock = ^(WZRefreshBaseView *refreshView){
        NSMutableDictionary *dictionar =[[NSMutableDictionary alloc]init];
        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<2; i++) {
            BaseCellMember *member = [[BaseCellMember alloc]init];
            if (i%2==0) {
                member.mainString = @"hello ?";
                member.detailString = @"cs";
                member.isShowImage = YES;
                member.imageName = [UIImage imageNamed:@"5"];
            }else{
                
                member.mainString =@"hello!";
                member.detailString = @"me";
                member.isShowImage = NO;
                member.imageName = nil;
            }
            [itemArray addObject:member];
        }
        [dictionar setObject:itemArray forKey:keyForRowData];
        [dictionar setObject:@"section" forKey:keyForSectionName];
        [tableViewC.dataArray addObject:dictionar];
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2];
        
    };
    headerView.endBlock = ^(WZRefreshBaseView *refreshView){
        NSLog(@"refresh is end!");
    };
    headerView.changeBlock = ^(WZRefreshBaseView *refreshView,WZRefreshState state ){
        switch (state) {
            case WZRefreshStateDidRefreshing:
            NSLog(@"refreshing");
            break;
            case WZRefreshStateNormal:
            NSLog(@"normal");
            break;
            case WZRefreshStatePulling:
            NSLog(@"pulling");
            break;
            case WZRefreshStateWillRefreshing:
            NSLog(@"willRefreshing");
            break;
            default:
            break;
        }
    };
    [headerView beginRefreshing];
    
}

-(void)doneWithView:(WZRefreshBaseView *)refreshView{
    WCustomTableView *tableVC = (WCustomTableView *)[self.view viewWithTag:10001];
    [tableVC reloadData];
    [refreshView endRefreshing];
}

@end
