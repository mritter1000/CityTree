//
//  IdentifyHomeViewController.h
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"
#import "BinTree.h"
#import "BasicTableViewController.h"
#import "IdentifyChoiceViewController.h"

@interface IdentifyHomeViewController : BasicTableViewController

@property (nonatomic, strong) BinTree *binTree;
@property (nonatomic, strong) UISegmentedControl *control;
@property (nonatomic, strong) NSArray *keyArray;

- (IBAction)changeSegment:(id)sender;
@end
