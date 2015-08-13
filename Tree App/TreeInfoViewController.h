//
//  TreeInfoViewController.h
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tree.h"
#import "BasicViewController.h"

@interface TreeInfoViewController : BasicViewController

@property (nonatomic, strong) IBOutlet UIImageView *treeImageView;
@property (nonatomic, strong) IBOutlet UIImageView *treeImageOverlay;
@property (nonatomic, strong) IBOutlet UIImageView *labelBackground;
@property (nonatomic, strong) IBOutlet UILabel *scientNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *commonNameLabel;
@property (nonatomic, strong) IBOutlet UIButton *shareButton;
@property (nonatomic, strong) IBOutlet UIButton *moreInfoButton;
@property (nonatomic, strong) Tree *tree;

- (IBAction)moreInfoPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;
@end
