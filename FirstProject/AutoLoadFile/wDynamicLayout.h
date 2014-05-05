//
//  wDynamicLayout.h
//  AutoLoodViewDemo
//
//  Created by 传晟 on 14-3-18.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderForMacro.h"
#import "CountString.h"

@interface wDynamicLayout : NSObject
@property(nonatomic,retain)NSMutableDictionary *items;
//@property(nonatomic,retain)NSArray *typeOfArray;
//@property(nonatomic,assign) NSInteger numOfItems;


-(void)loadItemsForGroup:(NSDictionary *)dictionary AndBaseView:(id)baseView;
-(id) viewOfItems:(NSDictionary *)array andTag:(NSInteger )num;
-(NSDictionary *)getItemsOfGroup:(NSDictionary *)wDictionary;//获取每个控键的类型和tag值

-(NSArray *)titleOfArrayOfTitleFormJSON:(NSDictionary *)dictionary;
-(NSArray *)imageOfArrayOfTitleFormJSON:(NSDictionary *)dictionary andString:(NSString *)string;

//返回自定义按钮的对象数组
-(NSArray *)instanceCustomButtonFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义表视图的对象数组
-(NSArray *)instanceCustomTabelViewFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;

@end
