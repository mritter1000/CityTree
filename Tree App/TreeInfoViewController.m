//
//  TreeInfoViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "TreeInfoViewController.h"
#import "BrowserViewController.h"

@interface TreeInfoViewController ()

@end

@implementation TreeInfoViewController
@synthesize treeImageView = _treeImageView;
@synthesize scientNameLabel = _scientNameLabel;
@synthesize commonNameLabel = _commonNameLabel;
@synthesize shareButton = _shareButton;
@synthesize moreInfoButton = _moreInfoButton;
@synthesize tree = _tree;
@synthesize labelBackground = _labelBackground;

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
    if(self.tree){
        [self loadTreeData];
    }
    [self setCustomTitle:@""];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.shareButton.hidden = YES;
    self.moreInfoButton.hidden = YES;
    self.treeImageOverlay.hidden = YES;
    self.treeImageView.hidden = YES;
    //CGRect frame = self.shareButton.frame;
    //frame.origin.y = self.treeImageView.frame.origin.y + self.treeImageView.frame.size.height - frame.size.height;
    //self.shareButton.frame = frame;
	// Do any additional setup after loading the view.
    
    CGRect frame = self.shareButton.frame;
    frame.origin.y = self.treeImageView.frame.origin.y + self.treeImageView.frame.size.height - frame.size.height;
    self.shareButton.frame = frame;
    if ([[ UIScreen mainScreen ] bounds ].size.height == 480)
    {
        self.treeImageOverlay.hidden = YES;
    }
    else
        self.treeImageOverlay.hidden = NO;

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.tree){
        [self loadTreeData];

    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.tree){
        [self loadTreeData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadTreeData
{
    self.scientNameLabel.text = self.tree.scientName;
    self.commonNameLabel.text = self.tree.commonName;
    int screenHeight = self.view.frame.size.height;
    if(screenHeight == 367){
        CGRect frame = self.treeImageView.frame;
        frame.size.height = 300;
        self.treeImageView.frame = frame;
        self.treeImageOverlay.frame = frame;
    }
    else if(screenHeight == 548)
    {
        CGRect frame = self.treeImageView.frame;
        frame.size.height = 385;
        self.treeImageView.frame = frame;
        self.treeImageOverlay.frame = frame;
    }


    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[self.tree.scientName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    if(image == nil){
        image = [UIImage imageNamed:@"sampleimg.jpg"];
        NSLog(@"Not Found: %@", self.tree.scientName);
    }
    self.treeImageView.image = image;
    [self.treeImageView setContentMode:UIViewContentModeScaleAspectFit];
    if ([UIScreen mainScreen].bounds.size.height > 500){
        [self.treeImageOverlay setContentMode:UIViewContentModeScaleAspectFill];
        self.shareButton.hidden = NO;
        self.moreInfoButton.hidden = NO;
        //self.treeImageOverlay.hidden = NO;
        self.treeImageView.hidden = NO;
    }
    else
    {
        [self.treeImageView setFrame:CGRectMake(0, 62, 320, 313)];
        
        [self.scientNameLabel setFrame:CGRectMake(20, 406, 280, 21)];
        [self.commonNameLabel setFrame:CGRectMake(20, 435, 280, 21)];

        [self.treeImageView setContentMode:UIViewContentModeScaleToFill];
    }
    
    
    
    CGRect frame = self.shareButton.frame;
    if(frame.size.width != 0){
        frame.origin.y = self.labelBackground.frame.origin.y - frame.size.height;
        self.shareButton.frame = frame;
        CGRect infoFrame = self.moreInfoButton.frame;
        infoFrame.origin.y = frame.origin.y;
        self.moreInfoButton.frame = infoFrame;
        CGRect commonFrame = self.commonNameLabel.frame;
        commonFrame.origin.y = self.labelBackground.frame.origin.y + 10;
        self.commonNameLabel.frame = commonFrame;
        self.shareButton.hidden = NO;
        self.moreInfoButton.hidden = NO;
       // self.treeImageOverlay.hidden = NO;
        self.treeImageView.hidden = NO;
    }

    
}
- (IBAction)exit:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


- (IBAction)moreInfoPressed:(id)sender
{
    BrowserViewController *bvc = [[BrowserViewController alloc] initWithNibName:@"BrowserViewController" bundle:nil];
    bvc.url = [[NSURL alloc] initWithString:[@"https://selectree.calpoly.edu/tree-detail/" stringByAppendingString: [self.tree.scientName stringByReplacingOccurrencesOfString:@" " withString:@"-" ]]];
    bvc.navigationController.title = self.tree.commonName;
    bvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bvc animated:YES];
}

-(IBAction)shareButtonPressed:(id)sender
{
    BOOL useAn = NO;
    char firstLetter = [self.tree.commonName characterAtIndex:0];
    switch (firstLetter) {
        case 'A':
        case 'E':
        case 'I':
        case 'O':
        case 'U':
            useAn = YES;
            break;
            
        default:
            useAn = NO;
            break;
    }
    NSString *textToShare = [NSString stringWithFormat:@"I've just identified %@ %@ (%@), using CityTree, an identification app for city trees. Learn the trees on your street with CityTree for the iPhone. https://itunes.apple.com/us/app/city-tree/id674380978?mt=8",(useAn ? @"an":@"a"),self.tree.commonName, self.tree.scientName];
    UIImage *imageToShare = self.treeImageView.image;
    NSArray *itemsToShare = @[textToShare, imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    [activityVC setValue:self.tree.commonName forKey:@"subject"];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToWeibo]; //or whichever you don't need
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
