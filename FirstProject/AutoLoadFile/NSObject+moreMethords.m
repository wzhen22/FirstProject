//
//  NSObject+moreMethords.m
//  FirstProject
//
//  Created by 传晟 on 14-4-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "NSObject+moreMethords.h"

@implementation NSObject (moreMethords)
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
//转换为button类型的方法
-(UIButtonType )buttonTypeFromMapper:(NSString *)string{
    UIButtonType butType;
    if ([string isEqualToString:@"0"]) {
        butType = UIButtonTypeCustom;
        return butType;
    }
    if ([string isEqualToString:@"1"]) {
        butType = UIButtonTypeRoundedRect;
        return butType;
    }
    if ([string isEqualToString:@"2"]) {
        butType = UIButtonTypeDetailDisclosure;
        return butType;
    }
    if ([string isEqualToString:@"3"]) {
        butType = UIButtonTypeInfoLight;
        return butType;
    }
    if ([string isEqualToString:@"4"]) {
        butType = UIButtonTypeInfoDark;
        return butType;
    }
    if ([string isEqualToString:@"5"]) {
        butType = UIButtonTypeContactAdd;
        return butType;
    }
    return butType = UIButtonTypeRoundedRect;
}

@end
