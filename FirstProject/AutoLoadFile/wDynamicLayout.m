//
//  wDynamicLayout.m
//  AutoLoodViewDemo
//
//  Created by 传晟 on 14-3-18.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "wDynamicLayout.h"
#import "WCustomTableView.h"
#import "customButton.h"


@interface wDynamicLayout (){

}

@end

@implementation wDynamicLayout{
    
}

-(void)loadItemsForGroup:(NSDictionary *)dictionary AndBaseView:(id)baseView{
//    CountString *lCount = [[CountString alloc]init];
    
    NSArray *typeOfArray = @[@"button",@"label",@"textField",@"customView",@"segment",@"slider",@"pageControl",@"scrollView",@"switch",@"imageView",@"tableView"];//用于判断接受控键的类型
    NSDictionary *lDictionary = dictionary;//通过json文件解析出来的字典用于动态布局
    NSInteger numOfitems;               //纪录需要布局的控键的个数
    numOfitems = [lDictionary allKeys].count;
    for (int i=0;  i<numOfitems;i++) {
        NSString *lKeyString = [NSString stringWithFormat:@"item_%d",i];
        NSDictionary *AttributeDic = [lDictionary objectForKey:lKeyString];
        for (int j = 0; j<typeOfArray.count; j++) {
            if ([[typeOfArray objectAtIndex:j]isEqualToString:[AttributeDic objectForKey:@"type"]]) {
                switch (j) {
                    case 0:{
                        customButton *button = [customButton loadButtonWithModer:AttributeDic];
                        [baseView addSubview:button];
                        break;
                    }//加载customButton
                    case 1:{
                        
                        break;
                    }//加载UILabel
                    case 2:{
                        
                        break;
                    }//加载UITextField
                    case 3:{
                        
                        break;
                    }//加载customView
                    case 4:{
                        
                        break;
                    }//加载UISegment自定义的
                    case 5:{
                        
                        break;
                    }//加载UISlider
                    case 6:{
                        
                        break;
                    }//加载UIPageControl
                    case 7:{
                        
                        break;
                    }//加载scrollView
                    case 8:{
                        
                        break;
                    }//加载customSwitch
                    case 9:{
                        
                        break;
                    }
                    case 10:{
                        WCustomTableView *wtableView = [WCustomTableView loadTableViewWithModer:AttributeDic];
                        [baseView addSubview:wtableView];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            //            NSLog(@"dsfdsfsdf");
        }

    }
    
    
}

#pragma mark load view tag methord
//根据json文件控制的又多少个布局块调用每块取tag值的方法
-(NSDictionary *)getItemsOfGroup:(NSDictionary *)wDictionary{
    NSMutableDictionary *lMdic = [[NSMutableDictionary alloc]init];
    NSInteger rows = [[wDictionary objectForKey:@"rowsOfType"] intValue];//纪录json描绘的有多少行

    for (int i= 0; i<rows; i++) {
        NSString *keyOfGroupItems = [NSString stringWithFormat:@"itemsOfGroup_%d",i];
        NSDictionary *lDic = [wDictionary objectForKey:keyOfGroupItems];
        [lMdic addEntriesFromDictionary:(NSMutableDictionary *)[self viewTagFromDictionary:lDic]];
    }
        return lMdic;
    SmartCellRelease(lMdic);
}
//每一块的控键类型在这里添加
-(NSDictionary *)viewTagFromDictionary:(NSDictionary *)dictionary{
    NSArray *typeOfArray = @[@"button",@"label",@"textField",@"customView",@"segment",@"slider",@"pageControl",@"scrollView",@"switch",@"tableView"];//用于判断接受控键的类型
    NSMutableDictionary *lMdic = [[NSMutableDictionary alloc]init];
    for (int i=0;  i<[dictionary.allKeys count];i++) {
        NSString *lKeyString = [NSString stringWithFormat:@"item_%d",i];
        NSDictionary *AttributeDic = [dictionary objectForKey:lKeyString];
        for (int j = 0; j<typeOfArray.count; j++) {
            if ([[typeOfArray objectAtIndex:j]isEqualToString:[AttributeDic objectForKey:@"type"]]) {
                switch (j) {
                    case 0:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"BkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 1:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"LkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 2:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"TkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 3:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"CkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        //把子布局字典里面的tag值存入总的返回字典
                        NSDictionary *subDic = [AttributeDic objectForKey:@"subItems"];//subItems与itemsOfGroup同级
                        NSDictionary *subOneDic = [self viewTagFromDictionary:subDic];
                        [lMdic addEntriesFromDictionary:subOneDic];
                        break;
                    }
                    case 4:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"SkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 5:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"SkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 6:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"PkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 7:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"SkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        //把子布局字典里面的tag值存入总的返回字典
                        NSDictionary *subDic = [AttributeDic objectForKey:@"subItems"];//subItems与itemsOfGroup同级
                        NSDictionary *subOneDic = [self viewTagFromDictionary:subDic];
                        [lMdic addEntriesFromDictionary:subOneDic];
                        break;
                    }
                    case 8:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"SkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    case 9:{
                        NSString *handlesOfType = [AttributeDic objectForKey:@"type"];
                        NSInteger numOfTag = [[AttributeDic objectForKey:@"TkeyOfTag"] intValue];
                        [lMdic setObject:handlesOfType forKey:[NSString stringWithFormat:@"%ld",(long)numOfTag]];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
        }
    }
    return lMdic;
}
-(id) viewOfItems:(NSDictionary *)array andTag:(NSInteger )num{
    return 0;
}
#pragma mark parse segment about items
-(NSArray *)titleOfArrayOfTitleFormJSON:(NSDictionary *)dictionary{
    NSMutableArray *jArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i<dictionary.allKeys.count; i++) {
        NSString *string = [dictionary objectForKey:[NSString stringWithFormat:@"segment_%d",i]];
        [jArray addObject:string];
    }
    return jArray;
}
-(NSArray *)imageOfArrayOfTitleFormJSON:(NSDictionary *)dictionary andString:(NSString *)string{
    NSMutableArray *jArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i<dictionary.allKeys.count; i++) {
        NSString *strings = [dictionary objectForKey:[NSString stringWithFormat:@"%@_%d",string,i]];
        UIImage *image = [UIImage imageNamed:strings];
        [jArray addObject:image];
    }
    return jArray;
}

#pragma mark base method
-(UIColor *)colorFromJSONnum:(NSInteger)num{
    UIColor *Rcolor;
    switch (num) {
        case 0:
            Rcolor  = [UIColor blackColor];
            break;
        case 1:
            Rcolor  = [UIColor darkGrayColor];
            break;
        case 2:
            Rcolor  = [UIColor lightGrayColor];
            break;
        case 3:
            Rcolor  = [UIColor whiteColor];
            break;
        case 4:
            Rcolor  = [UIColor grayColor];
            break;
        case 5:
            Rcolor  = [UIColor redColor];
            break;
        case 6:
            Rcolor  = [UIColor greenColor];
            break;
        case 7:
            Rcolor  = [UIColor blueColor];
            break;
        case 8:
            Rcolor  = [UIColor cyanColor];
            break;
        case 9:
            Rcolor  = [UIColor yellowColor];
            break;
        case 10:
            Rcolor  = [UIColor magentaColor];
            break;
        case 11:
            Rcolor  = [UIColor orangeColor];
            break;
        case 12:
            Rcolor  = [UIColor purpleColor];
            break;
        case 13:
            Rcolor  = [UIColor brownColor];
            break;
        case 14:
            Rcolor  = [UIColor clearColor];
            break;

        default:
        Rcolor  = [UIColor clearColor];
            break;
    }
    return Rcolor;
}

-(NSTextAlignment) acheiveTextAlignmentFromJSONnum:(NSInteger)num{
    NSTextAlignment textAlignment;
    switch (num) {
        case 1:
        textAlignment = NSTextAlignmentCenter;
        break;
        case 2:
        textAlignment = NSTextAlignmentRight;
        break;
        case 3:
        textAlignment = NSTextAlignmentJustified;
        break;
        case 4:
        textAlignment = NSTextAlignmentNatural;
        break;
        default:
        textAlignment = NSTextAlignmentLeft;
        break;
    }
    return textAlignment;
}

-(CGPoint) pointFromJSON:(NSDictionary *)dictionary{
    CGPoint point;
    CGFloat x = [[dictionary objectForKey:@"keyPoint_x"] floatValue];
    CGFloat y = [[dictionary objectForKey:@"keyPoint_y"] floatValue];
    point.x = x;
    point.y = y;
    return point;
}

-(CGSize )sizeFromJSON:(NSDictionary *)dictionary{
    CGSize size;
    CGFloat width = [[dictionary objectForKey:@"keySize_width"] floatValue];
    CGFloat height = [[dictionary objectForKey:@"keySize_height"] floatValue];
    size.width = width;
    size.height = height;
    return size;
}

-(CGRect )rectFromJSON:(NSDictionary *)dictionary{
    CGRect rect;
    NSDictionary  *dicForPoint = [dictionary objectForKey:@"keyPoint"];
    NSDictionary *dicForSize = [dictionary objectForKey:@"keySize"];
    rect.origin = [self pointFromJSON:dicForPoint];
    rect.size = [self sizeFromJSON:dicForSize];
    return rect;
}

-(BOOL) boolFromJSON:(NSInteger )integer{
    BOOL isOK;
    if (integer != 0) {
        isOK = YES;
    }else{
        isOK  = NO;
    }
    return isOK;
}

-(UIImage *)imageFromJSON:(NSString *)string{
    UIImage *image = [UIImage imageNamed:string];
    return image;
}
-(UIViewContentMode)modeFromJSON:(NSInteger )integer{
    UIViewContentMode contentMode=UIViewContentModeScaleAspectFill;
    if (integer ==0) {
        contentMode = UIViewContentModeScaleAspectFill;
    }
    if (integer == 1) {
        contentMode = UIViewContentModeScaleAspectFit;
    }
    if (integer == 2) {
        contentMode = UIViewContentModeScaleToFill;
    }
    return contentMode;
}
-(void)textClick{
    //do any additional setup
    NSLog(@"text disappear!");
    
}

@end
