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
#import "customButton.h"
#import "FirstViewController.h"

@interface ViewController (){

    NSArray *widgetArray;
}
@end

#define BackName1 @"4.png"
#define BackName2 @"3.png"
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    NSString *lstring = [[NSBundle mainBundle] resourcePath];
    NSString *path = [lstring stringByAppendingPathComponent:@"baseViewController.json"];
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
    widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    
    
    
//    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(130, 200, 60, 40)];
//    labe.text = @"hdddd";
//    labe.backgroundColor = [UIColor grayColor];
//    labe.layer.cornerRadius = 10;
//    [self.view addSubview:labe];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    button.frame = CGRectMake(10, 300, 60, 40);
//    button.backgroundColor = [UIColor blackColor];
//    [button setTitle:@"din" forState:UIControlStateNormal];
//    button.layer.cornerRadius = 10;
//    [self.view addSubview:button];
}

#pragma mark 事件响应通过tag值取出后的描述方法
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    //        [cB performSelector:@selector(buttonClick:)];
                    if (cB.clickOfType == 1) {
                        FirstViewController *lFirstVC = [[FirstViewController alloc]init];
                        [self presentViewController:lFirstVC animated:YES completion:nil];
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

@end
