//
//  BasicViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

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

    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"offer_list_cell.png"]];
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
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"PrimaryBackgroundImage.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

	// Do any additional setup after loading the view.
}

- (void) setCustomTitle: (NSString*) titleString
{
    self.navigationItem.title = nil;
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    NSLog(@"%f, %f, %f, %f",self.navigationController.navigationBar.bounds.origin.x, self.navigationController.navigationBar.bounds.origin.y, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height);
	[titleLabel setText:titleString];
    UIImageView *titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HeaderLogo.png"] highlightedImage:nil];
    [titleImg setContentMode:UIViewContentModeScaleAspectFit];

	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.font = [UIFont fontWithName:@"Helvetica" size:28.0];
    CGFloat red = 159.0/255.0;
    CGFloat green = 224.0/255.0;
    CGFloat blue = 29.0/255.0;
    titleLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //    titleLabel.shadowColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.4];
    //    titleLabel.shadowOffset = CGSizeMake(0.5, 1.0);
    
	titleLabel.backgroundColor = [UIColor clearColor];
	[titleLabel sizeToFit];
    
	
	self.navigationItem.titleView = titleImg;
    
}
- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
