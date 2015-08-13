//
//  BrowserViewController.h
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPWebViewController.h"
@interface BrowserViewController : PRPWebViewController

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;

@end
