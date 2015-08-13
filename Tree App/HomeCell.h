//
//  HomeCell.h
//  Tree Guru
//
//  Created by Bria Sullivan on 6/5/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *topLabel;
@property (nonatomic, strong) IBOutlet UILabel *bottomLabel;
@property (nonatomic, strong) IBOutlet UILabel *plainLabel;
@property (nonatomic, strong) IBOutlet UIImageView *nodeImgView;

@end
