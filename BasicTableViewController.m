//
//  BasicTableViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "BasicTableViewController.h"

@interface BasicTableViewController ()

@end

@implementation BasicTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-  (void)dismissit:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
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

    UIImageView *bgview = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgview setImage:[UIImage imageNamed:@"PrimaryBackgroundImage.png"]];
    self.tableView.backgroundView = bgview;
    UISwipeGestureRecognizer *SwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissit:)];
    SwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:SwipeRight];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void) setCustomTitle: (NSString*) titleString
{
    self.navigationItem.title = nil;
    UIImageView *titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HeaderLogo.png"] highlightedImage:nil];
    [titleImg setContentMode:UIViewContentModeScaleAspectFit];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.bounds];
	[titleLabel setText:titleString];
	
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:28.0];
    titleLabel.textColor = [UIColor colorWithRed:112.0/255.0
                                           green:156.0/255.0
                                            blue:25.0/255.0
                                           alpha:1.0];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
