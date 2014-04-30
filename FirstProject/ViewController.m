//
//  ViewController.m
//  FirstProject
//
//  Created by 传晟 on 14-4-28.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ViewController.h"
#import "wDynamicLayout.h"
#import "WCustomTableView.h"
#import "BaseCellMember.h"
#import "HeaderAndFooterRefresh.h"

@interface ViewController ()

@end
#define keyForRowData @"rowItems"
#define keyForSectionName @"sectionName"
@implementation ViewController

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
//    WCustomTableView *wCusTV = (WCustomTableView *)[self.view viewWithTag:10001];
//    wCusTV.delegate = self;
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典
    NSLog(@"***************%@",ldic);
    [self addHeader];
}

#pragma mark 事件响应通过tag值取出后的描述方法
-(void)achieveHandle:(NSDictionary *)dictionary{
    [self addHeader];
    
}
#pragma mark 表视图的头部刷新控件关联
- (void)addHeader
{
    WCustomTableView *tableVC = (WCustomTableView *)[self.view viewWithTag:10001];
    RefreshHeaderView *headerView = [RefreshHeaderView header];
    headerView.scrollView  = tableVC;
    headerView.beginBolock = ^(WZRefreshBaseView *refreshView){
//        WZRefreshBaseView *baseView = [[WZRefreshBaseView alloc]init];
//        refreshView = baseView;
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
        [tableVC.dataArray addObject:dictionar];
//        [tableVC performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2];
        
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
