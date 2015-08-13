//
//  BrowserViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIImageView *titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HeaderLogo.png"] highlightedImage:nil];
    [titleImg setContentMode:UIViewContentModeScaleAspectFit];

    
	
	self.navigationItem.titleView = titleImg;
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"offer_list_cell.png"]];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 43, 44);
    
    if([self.navigationController.viewControllers count] > 1){
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.frame = CGRectMake(0, 0, 43, 44);
        
        UIImage *backImage = [UIImage imageNamed:@"HeaderBackButton.png"];
        [back setContentMode:UIViewContentModeScaleAspectFit];
        [back setBackgroundImage:backImage forState:UIControlStateNormal];
        [back addTarget:self action:@selector(back)
       forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithCustomView:back];
        [self.navigationItem setLeftBarButtonItem:bbi];
    }

    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 30), self.view.frame.size.width, 50)];
    [toolbar setBackgroundImage:[UIImage imageNamed:@"offer_list_cell.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    self.backButton = [[UIBarButtonItem alloc] init];
    [self.backButton setAction:@selector(goBack)];
    [self.backButton setImage:[UIImage imageNamed:@"WebViewBack.png"]];
    self.forwardButton = [[UIBarButtonItem alloc] init];
    [self.forwardButton setAction:@selector(goForward)];
    [self.forwardButton setImage:[UIImage imageNamed:@"WebViewForward.png"]];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:self.backButton];
    [items addObject:self.forwardButton];
    [toolbar setItems:items];
    [self.view addSubview:toolbar];

    [self.webView setFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height - 45)];
    [self.webView setScalesPageToFit:YES];
    
}
- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self.backButton setEnabled:[webView canGoBack]];
    [self.forwardButton setEnabled:[webView canGoForward]];
    
}
- (void)goBack
{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }
}
- (void) goForward
{
    if([self.webView canGoForward]){
        [self.webView goForward];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
