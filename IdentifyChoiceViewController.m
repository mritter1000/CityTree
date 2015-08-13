//
//  IdentifyChoiceViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 5/8/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "IdentifyChoiceViewController.h"
#import "Tree.h"
#import "SpeciesListParser.h"
#import "TreeInfoViewController.h"

@interface IdentifyChoiceViewController ()

@end

@implementation IdentifyChoiceViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCustomTitle:@"Tree Guru"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    
    if ([[ UIScreen mainScreen ] bounds ].size.height == 480)
    {
        self.tableView.scrollEnabled = YES;
        
    }
    else
    self.tableView.scrollEnabled = NO;


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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.binTree.children count];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }*/
    
    IdentifyChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (IdentifyChoiceCell *) [[[NSBundle mainBundle] loadNibNamed:@"IdentifyChoiceCell" owner:self options:nil]objectAtIndex:0];
    }

    /*if(indexPath.row == 0){
        //cell.textLabel.text = self.binTree.left.text;
        cell.textLabel.text = ((Node*)[self.binTree.children objectAtIndex:0]).text;
    }else{
        if([self.binTree.children count] > 1){
            //cell.textLabel.text = self.binTree.right.text;
            cell.textLabel.text = ((Node*)[self.binTree.children objectAtIndex:1]).text;
        }
    }*/
    
    if ([self.binTree.children count]==2)
    {
        [cell.text setFrame:CGRectMake(13,70,195,85)];
        [cell.normalLabel setFrame:CGRectMake(13,70,271,99)];
        
    }
    if ([self.binTree.children count]==3)
    {
        [cell.text setFrame:CGRectMake(13,30,195,85)];

        [cell.normalLabel setFrame:CGRectMake(13,30,271,99)];

    }
    cell.text.text = ((Node*)[self.binTree.children objectAtIndex:indexPath.row]).text;
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    Node *tempNode = [self.binTree.children objectAtIndex:indexPath.row];
    
    cell.text.lineBreakMode = NSLineBreakByWordWrapping;
   // [cell.text setTextAlignment:NSTextAlignmentCenter];
    
    cell.text.font = [UIFont systemFontOfSize:16.0];
    NSLog(@"%f", [self tableView:tableView heightForRowAtIndexPath:indexPath]);
    if([self tableView:tableView heightForRowAtIndexPath:indexPath] < 130)
    {
        
        [cell.normalLabel setNumberOfLines:5];
        [cell.text setNumberOfLines:5];
    }else{
        [cell.normalLabel setNumberOfLines:7];
        [cell.text setNumberOfLines:7];
    }
    if(tempNode.imgPath != nil && tempNode.imgPath.length > 0){
        [cell.imgView setContentMode:UIViewContentModeScaleAspectFit];
        cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", tempNode.imgPath]];
        [cell layoutSubviews];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }
    else
    {
        [cell.imgView setHidden:YES];
        cell.normalLabel.text = cell.text.text;
        [cell.normalLabel setHidden:NO];
        [cell.text setHidden:YES];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
/*    if([cell.text.text rangeOfString:@"Leaves scale-like or awl-like"].location != NSNotFound){
        cell.imgView.image = [UIImage imageNamed:@"scale-like-leaves.png"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }else if([cell.text.text rangeOfString:@"Leaves needle-like, 3/4 in. long or longer"].location != NSNotFound){
        cell.imgView.image = [UIImage imageNamed:@"needle-like-leaves.png"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }else if([cell.text.text rangeOfString:@"Leaves compound (divided into leaflets)"].location != NSNotFound){
        cell.imgView.image = [UIImage imageNamed:@"compound-leaves.png"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }else if([cell.text.text rangeOfString:@"Leaves simple (with undivided blades, deeply lobed leaves"].location != NSNotFound){
        cell.imgView.image = [UIImage imageNamed:@"simple-leaves.png"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }else if([cell.text.text rangeOfString:@"Leaves attached oppositely (2 per node) or whorled (3 or more per node)"].location != NSNotFound){
        cell.imgView.image = [UIImage imageNamed:@"opposite_whorled.png"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }else if([cell.text.text rangeOfString:@"Leaves attached alternately (1 per node)"].location != NSNotFound){
        cell.imgView.image = [UIImage imageNamed:@"alternate.png"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.imgView setHidden:NO];
        [cell.text setHidden:NO];
        [cell.normalLabel setHidden:YES];
    }else{
        [cell.imgView setHidden:YES];
        cell.normalLabel.text = cell.text.text;
        [cell.normalLabel setHidden:NO];
        [cell.text setHidden:YES];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }*/

    // Configure the cell...
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.binTree.children count]==2)
    {
        return 228;
    }
   else if ([self.binTree.children count]==3)
    {
        return 153;
    }
   else if ([self.binTree.children count]==4)
   {
       return 115;
   }
    else
    return self.view.frame.size.height  / [self.binTree.children count];
  
    //return 115;
}

/*- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"What best describes your tree?";
}
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,60)];
    customView.backgroundColor = [UIColor colorWithRed:112.0/255.0
                                                 green:156.0/255.0
                                                  blue:25.0/255.0
                                                 alpha:1.0];
    
    
    // create the label objects
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont italicSystemFontOfSize:14.0];
    headerLabel.frame = CGRectMake(5,0,295,20);
    headerLabel.text =  [self tableView:tableView titleForHeaderInSection:section];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor whiteColor];
    
    [customView addSubview:headerLabel];
    
    return customView;
}
*/
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
    IdentifyChoiceViewController *ivc = [[IdentifyChoiceViewController alloc] initWithNibName:@"IdentifyChoiceViewController" bundle:[NSBundle mainBundle]];
    ivc.binTree = [self.binTree.children objectAtIndex:indexPath.row];
     if([((Node*)[self.binTree.children objectAtIndex:indexPath.row]).children count] > 1){
        [self.navigationController pushViewController:ivc animated:YES];
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TempSpeciesList" ofType:@"csv"];
        SpeciesListParser *treeparser = [[SpeciesListParser alloc] initWithContentsOfFile:path];
        Tree *tree = [treeparser findTreeWithString:((Node*)[ivc.binTree.children objectAtIndex:0]).text];
        if(tree != nil){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            TreeInfoViewController *tvc = [storyboard instantiateViewControllerWithIdentifier:@"treeInfo"];
            [tvc setTree:tree];
            [self.navigationController pushViewController:tvc animated:YES];
        }else{
            NSLog(@"OOHHH NOOOO");
        }
    }

}

@end
