//
//  TreeListViewController.h
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicTableViewController.h"

@interface TreeListViewController : BasicTableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *treeArray;
@property (strong,nonatomic) NSMutableArray *filteredTreeArray;
@property IBOutlet UISearchBar *treeSearchBar;
@property IBOutlet UISegmentedControl *segmentControl;
@end
