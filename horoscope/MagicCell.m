//
//  MagicCell.m
//  MemoryTest
//
//  Created by JessieYong on 13-11-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MagicCell.h"

@implementation MagicCell

@synthesize textView = _textView;
@synthesize image = _image;

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
