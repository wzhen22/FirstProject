//
//  CustomView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setimageWithView:(Myblock)block{
    self.customViewBlock = block;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.customViewBlock(self);
    
    //    NSLog(@"hello");
}


@end
