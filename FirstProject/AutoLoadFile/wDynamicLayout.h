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

-(UIColor *)colorFromJSONnum:(NSInteger)num;//转换为基本颜色样式

-(NSTextAlignment) acheiveTextAlignmentFromJSONnum:(NSInteger)num;//转换为支持的文字对齐方式

-(CGPoint) pointFromJSON:(NSDictionary *)dictionary;//返回点坐标

-(CGSize )sizeFromJSON:(NSDictionary *)dictionary;//返回size的宽和高

-(CGRect )rectFromJSON:(NSDictionary *)dictionary;//返回一个rect值

-(BOOL) boolFromJSON:(NSInteger )integer;

-(NSDictionary *)viewTagFromDictionary:(NSDictionary *)dictionary;

-(UIImage *)imageFromJSON:(NSString *)string;

-(UIViewContentMode)modeFromJSON:(NSInteger )integer;

@end
