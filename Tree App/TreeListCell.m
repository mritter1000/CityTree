//
//  TreeListCell.m
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "TreeListCell.h"

@implementation TreeListCell
@synthesize topLabel = _topLabel;
@synthesize bottomLabel = _bottomLabel;


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
