//
//  CImageVIew.m
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CImageVIew.h"
#import "ImageViewOfMapper.h"

@implementation CImageVIew
+(CImageVIew *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    ImageViewOfMapper *imageVMapper = [ImageViewOfMapper modelObjectWithDictionary:dictionary];
    CImageVIew *imageView = [[CImageVIew alloc]init];
    CGRect cRect = [imageView rectFromModelJSON:imageVMapper];
    imageView.frame = cRect;
    imageView.backgroundColor = [imageView colorFromJSONnum:[imageVMapper.backGColor integerValue]];
    imageView.contentMode = [imageView modeFromJSON:[imageVMapper.ContemMode integerValue]];
    if ([imageView boolFromJSON:[imageVMapper.isAnimation integerValue]]) {
        imageView.animationImages = imageVMapper.animationImages;
        imageView.animationDuration = [imageVMapper.animationDuration floatValue];
        imageView.animationRepeatCount = [imageVMapper.animationRepeateCount floatValue];
        [imageView startAnimating];
    }else{
        imageView.image = [UIImage imageNamed:imageVMapper.ImageName];
    
    }
    imageView.tag = [imageVMapper.tag intValue];
    return imageView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(ImageViewOfMapper *)imageViewOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [imageViewOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [imageViewOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [imageViewOfMapper.widthOfRect floatValue];
    table_rect.size.height = [imageViewOfMapper.heightOfRect floatValue];
    return table_rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
