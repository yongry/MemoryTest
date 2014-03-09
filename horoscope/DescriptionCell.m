//
//  DescriptionCell.m
//  MemoryTest
//
//  Created by JessieYong on 13-11-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "DescriptionCell.h"
#import "InfoClient.h"

@implementation DescriptionCell

@synthesize numberLabel = _numberLabel;
@synthesize colorLabel = _colorLabel;
@synthesize horoscopeLabel = _horoscopeLabel;
//@synthesize textView = _textView;
@synthesize allLabel = _allLabel;
@synthesize loveLabel = _loveLabel;
@synthesize moneyLabel = _moneyLabel;
@synthesize workLabel = _workLabel;

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
