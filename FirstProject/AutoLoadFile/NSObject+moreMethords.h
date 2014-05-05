//
//  NSObject+moreMethords.h
//  FirstProject
//
//  Created by 传晟 on 14-4-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (moreMethords)
-(UIColor *)colorFromJSONnum:(NSInteger)num;//转换为基本颜色样式

-(NSTextAlignment) acheiveTextAlignmentFromJSONnum:(NSInteger)num;//转换为支持的文字对齐方式

-(CGPoint) pointFromJSON:(NSDictionary *)dictionary;//返回点坐标

-(CGSize )sizeFromJSON:(NSDictionary *)dictionary;//返回size的宽和高

-(CGRect )rectFromJSON:(NSDictionary *)dictionary;//返回一个rect值

-(BOOL) boolFromJSON:(NSInteger )integer;//转换为一个bool型值

-(UIImage *)imageFromJSON:(NSString *)string;//通过名称装换为图片

-(UIViewContentMode)modeFromJSON:(NSInteger )integer;//返回视图包含子视图的类型

-(UIButtonType )buttonTypeFromMapper:(NSString *)string;//返回按钮的类型样式

@end
