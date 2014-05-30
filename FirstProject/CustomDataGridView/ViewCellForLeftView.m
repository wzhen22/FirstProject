//
//  ViewCellForLeftView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-30.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ViewCellForLeftView.h"
#import "LabelForLeftView.h"

@implementation ViewCellForLeftView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[LabelForLeftView alloc]initWithFrame:CGRectMake(17, -1, self.frame.size.width, self.frame.size.height * 0.3)];
        [self.titleLabel setVerticalAlignment:VerticalAlignmentTop];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
