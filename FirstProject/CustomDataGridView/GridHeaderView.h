//
//  GridHeaderView.h
//  FirstProject
//
//  Created by 传晟 on 14-5-28.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GridHeaderView;
@protocol GridHeaderViewDelegate <NSObject>

-(void)headView:(GridHeaderView *)headView point:(CGPoint )point;

@end

@interface GridHeaderView : UIView

@property(nonatomic,strong) NSString *num;
@property(nonatomic,strong) NSString *detail;
@property(nonatomic,assign) id <GridHeaderViewDelegate> delegate;

@end
