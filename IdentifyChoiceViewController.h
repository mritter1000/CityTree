//
//  IdentifyChoiceViewController.h
//  Tree App
//
//  Created by Bria Sullivan on 5/8/13.
//  Copyright (c) 2013 vThirtyFive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BinTree.h"
#import "Node.h"
#import "BasicTableViewController.h"
#import "IdentifyChoiceCell.h"

@interface IdentifyChoiceViewController : BasicTableViewController
{
    IdentifyChoiceCell *objIdentifyChoice;
}

@property (nonatomic, strong) Node *binTree;
@end
