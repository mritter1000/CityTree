//
//  PPRWebViewController.m
//
//  Created by Matt Drance on 6/30/10.
//  Copyright 2010 Bookhouse. All rights reserved.
//

#import "PRPWebViewController.h"

const float PRPWebViewControllerFadeDuration = 0.5;

@interface PRPWebViewController ()

- (void)fadeWebViewIn;
- (void)resetBackgroundColor;

@end

@implementation PRPWebViewController

@synthesize url;

@synthesize backgroundColor;
@synthesize webView;
@synthesize activityIndicator;

@synthesize showsDoneButton;

@synthesize delegate;



- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.webView = nil;
    self.activityIndicator = nil;
}

- (void)loadView {
    UIViewAutoresizing resizeAllMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    mainView.autoresizingMask = resizeAllMask;
    self.view = mainView;
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = resizeAllMask;
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    // START:ViewCentering
    activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleRightMargin |
                                        UIViewAutoresizingFlexibleBottomMargin |
                                        UIViewAutoresizingFlexibleLeftMargin;
    CGRect aiFrame = self.activityIndicator.frame;
    CGFloat originX = (self.view.bounds.size.width - aiFrame.size.width) / 2;
    CGFloat originY = (self.view.bounds.size.height - aiFrame.size.height) / 2;
    aiFrame.origin.x = floorl(originX);
    aiFrame.origin.y = floorl(originY);
    self.activityIndicator.frame = aiFrame;
    // END:ViewCentering
    [self.view addSubview:activityIndicator];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetBackgroundColor];
    [self reload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    BOOL shouldRotate = YES;
    
    if ([self.delegate respondsToSelector:@selector(webController:shouldAutorotateToInterfaceOrientation:)]) {
        shouldRotate = [self.delegate webController:self shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    
    return shouldRotate;
}

#pragma mark -
#pragma mark Actions

- (void)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)fadeWebViewIn {
    [UIView animateWithDuration:PRPWebViewControllerFadeDuration
                     animations:^ {
                         self.webView.alpha = 1.0;                         
                     }];
}

- (void)reload {
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        self.webView.alpha = 0.0;
        [self.activityIndicator startAnimating];        
    }
}

#pragma mark -
#pragma mark Accessor overrides

// START:ShowDoneButton
- (void)setShowsDoneButton:(BOOL)shows {
    if (showsDoneButton != shows) {
        showsDoneButton = shows;
        if (showsDoneButton) {
            UIBarButtonItem *done = [[UIBarButtonItem alloc] 
                initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                     target:self
                                     action:@selector(doneButtonTapped:)];
            self.navigationItem.rightBarButtonItem = done;
        } else {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
}
// END:ShowDoneButton

// START:SetBGColor
- (void)setBackgroundColor:(UIColor *)color {
    if (backgroundColor != color) {

        [self resetBackgroundColor];
    }
}
// END:SetBGColor

// START:ResetBG
- (void)resetBackgroundColor {
    if ([self isViewLoaded]) {
        UIColor *bgColor = self.backgroundColor;
        if (bgColor == nil) {
            bgColor = [UIColor colorWithRed:112.0/255.0
                                      green:156.0/255.0
                                       blue:25.0/255.0
                                      alpha:1.0];
        }
        self.view.backgroundColor = bgColor;
    }
}
// END:ResetBG

#pragma mark -
#pragma mark UIWebViewDelegate

// START:WebLoaded
- (void)webViewDidFinishLoad:(UIWebView *)wv {
    [self.activityIndicator stopAnimating];
    [self fadeWebViewIn];
    if (self.title == nil) {
        NSString *docTitle = [self.webView 
            stringByEvaluatingJavaScriptFromString:@"document.title;"];
        if ([docTitle length] > 0) {
            self.navigationItem.title = docTitle;
        }
    }
}
// END:WebLoaded

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
    NSLog(@"webView fail: %@", error);
    [self.activityIndicator stopAnimating];
    if ([self.delegate respondsToSelector:@selector(webController:didFailLoadWithError:)]) {
        [self.delegate webController:self didFailLoadWithError:error];
    } else {
        if ([error code] != kCFURLErrorCancelled) {            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Failed"
                                                            message:@"The web page failed to load."
                                                           delegate:nil cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end