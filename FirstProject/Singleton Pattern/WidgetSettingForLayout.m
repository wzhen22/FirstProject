//
//  WidgetSettingForLayout.m
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WidgetSettingForLayout.h"

static WidgetSettingForLayout *wsfLayout = nil;
@implementation WidgetSettingForLayout
+(WidgetSettingForLayout *)sharAllMableAttribute{
    @synchronized(self){
        if (wsfLayout == nil) {
            wsfLayout = [[WidgetSettingForLayout alloc] init];
            
        }
    }
    
    return wsfLayout;
}
@end
