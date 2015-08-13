//
//  IdentifyChoiceCell.m
//  Tree Guru
//
//  Created by Bria Sullivan on 6/11/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "IdentifyChoiceCell.h"

@implementation IdentifyChoiceCell

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


- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(225, (self.frame.size.height / 2) - (85 /2), 85.0, 85.0);
    NSLog(@"%f",self.imgView.frame.origin.y);

}

@end
