//
//  GridHeaderView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-28.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "GridHeaderView.h"

@interface GridHeaderView()
@property (nonatomic,strong) UILabel *numRoom;
@property (nonatomic,strong) UILabel *detailRoom;
@end

@implementation GridHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numRoom=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5)];
        self.numRoom.textAlignment=NSTextAlignmentCenter;
        self.numRoom.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.25);
        [self addSubview:self.numRoom];
        
        self.detailRoom=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5)];
        self.detailRoom.textAlignment=NSTextAlignmentCenter;
        self.detailRoom.font=[UIFont systemFontOfSize:12];
        self.detailRoom.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height-self.frame.size.height*0.25);
        [self addSubview:self.detailRoom];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)]];
    }
    return self;
}
-(void)tapView:(UITapGestureRecognizer *)tap
{
    CGPoint point=[tap locationInView:self];
    
    if([self.delegate respondsToSelector:@selector(headView:point:)]){
        
        [self.delegate headView:self point:point];
    }
    
}
-(void)setNum:(NSString *)num
{
    _num=num;
    self.numRoom.text=num;
}
-(void)setDetail:(NSString *)detail
{
    _detail=detail;
    self.detailRoom.text=detail;
    
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
