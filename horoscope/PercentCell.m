//
//  PercentCell.m
//  MemoryTest
//
//  Created by JessieYong on 13-11-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "PercentCell.h"

@implementation PercentCell


@synthesize imageAll = _imageAll;
@synthesize imageLove = _imageLove;
@synthesize imageMoney = _imageMoney;
@synthesize imageWork = _imageWork;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
