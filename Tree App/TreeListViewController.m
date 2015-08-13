//
//  TreeListViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 4/24/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "TreeListViewController.h"
#import "Tree.h"
#import "SpeciesListParser.h"
#import "TreeInfoViewController.h"
#import "TreeListCell.h"
#import "BinTree.h"

@interface TreeListViewController (){
    NSMutableArray *sectionTitles;
}

@end

@implementation TreeListViewController
@synthesize treeArray = _treeArray;
@synthesize treeSearchBar = _treeSearchBar;
@synthesize filteredTreeArray = _filteredTreeArray;
@synthesize segmentControl = _segmentControl;

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
    [self.tableView setRowHeight:80.0];
    sectionTitles = [[NSMutableArray alloc] init];
//    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], UITextAttributeTextColor,
                            //[UIFont systemFontOfSize:10.0], UITextAttributeFont,
                          //nil];
    //[self.segmentControl setTitleTextAttributes:attr forState:UIControlStateNormal];
//    [self.segmentControl setTintColor:[UIColor colorWithRed:112.0/255.0
//                                                      green:156.0/255.0
//                                                       blue:25.0/255.0
//                                                      alpha:1.0]];
    UIImage *unselectedImage = [[UIImage imageNamed:@"SegmentedController.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *selectedImage = [[UIImage imageNamed:@"SegmentedControllerSelected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    // [UIImage imageNamed:@""] res
    //UIImage *unselectedImage = [UIImage imageNamed:@"SegmentedController.png"];
    //UIImage *selectedImage = [UIImage imageNamed:@"SegmentedControllerSelected.png"] ;
    [[UISegmentedControl appearance] setBackgroundImage:unselectedImage
                                               forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:selectedImage
                                               forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TempSpeciesList" ofType:@"csv"];
    SpeciesListParser *treeparser = [[SpeciesListParser alloc] initWithContentsOfFile:path];
    self.treeArray = treeparser.speciesArray;
    self.treeArray = [self.treeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *common1 = ((Tree*) obj1).commonName;
        NSString *common2 = ((Tree*) obj2).commonName;
        return [common1 compare:common2];
    }];
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
    
    NSString *letter, *letter2;
    int j = 0;
    for (int i = 1; i < [self.treeArray count]; i++)
    {
        if([sectionArray count] == 0){
            [sectionArray addObject:[self.treeArray objectAtIndex:0]];
        }
        letter = [((Tree *)[sectionArray objectAtIndex:j]).commonName substringToIndex:1];
        letter2 = [((Tree *)[self.treeArray objectAtIndex:i]).commonName substringToIndex:1];
        if (![letter isEqual:[((Tree *)[self.treeArray objectAtIndex:i]).commonName substringToIndex:1]] ){
            
            [sectionTitles addObject:sectionArray];
            sectionArray = [[NSMutableArray alloc] init];
            j = 0;
        }else{
            j++;
        }
            [sectionArray addObject:[self.treeArray objectAtIndex:i]];
        
    }
    self.filteredTreeArray = [NSMutableArray arrayWithCapacity:[self.treeArray count]];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //[self.treeSearchBar setBarTintColor:[UIColor colorWithRed:80.0 green:60.0 blue:35.0 alpha:0]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return 1;
    }else{
        return [sectionTitles count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [self.filteredTreeArray count];
    }

    return [[sectionTitles objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TreeListCell *cell = (TreeListCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (TreeListCell *) [[[NSBundle mainBundle] loadNibNamed:@"TreeListCell" owner:self options:nil]objectAtIndex:0];
    }
    Tree *tree;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        tree = [self.filteredTreeArray objectAtIndex:indexPath.row];
    }else{
        tree = [[sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[tree.scientName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    if(image == nil){
        image = [UIImage imageNamed:@"sampleimg.jpg"];
        NSLog(@"Not Found: %@", tree.scientName);
    }
    
    if(self.segmentControl.selectedSegmentIndex == 0){
        cell.topLabel.text = tree.commonName;
        cell.topLabel.font = [UIFont systemFontOfSize:18.0];
        cell.bottomLabel.text = tree.scientName;
        cell.bottomLabel.font = [UIFont italicSystemFontOfSize:16.0];
    }else{
        cell.topLabel.text = tree.scientName;
        cell.topLabel.font = [UIFont italicSystemFontOfSize:18.0];
        cell.bottomLabel.text = tree.commonName;
        cell.bottomLabel.font = [UIFont systemFontOfSize:16.0];

    }
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return nil;
    }
    if (self.segmentControl.selectedSegmentIndex == 0){
        return [((Tree *)[[sectionTitles objectAtIndex:section]objectAtIndex:0]).commonName substringToIndex:1];
    }else{
        return [((Tree *)[[sectionTitles objectAtIndex:section]objectAtIndex:0]).scientName substringToIndex:1];
    }
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
    headerLabel.font = [UIFont boldSystemFontOfSize:14.0];
    headerLabel.frame = CGRectMake(5,0,295,20);
    headerLabel.text =  [self tableView:tableView titleForHeaderInSection:section];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor whiteColor];
    
    [customView addSubview:headerLabel];
    
    return customView;
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

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (title == UITableViewIndexSearch)
    {
        CGRect searchBarFrame = self.searchDisplayController.searchBar.frame;
        [tableView scrollRectToVisible:searchBarFrame animated:NO];
        return -1;
    }
    return index - 1;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    [titles addObject:UITableViewIndexSearch];
    if (self.segmentControl.selectedSegmentIndex == 0)
    {
        for(int i = 0; i < [sectionTitles count]; i++)
        {
            [titles addObject:[((Tree *)[[sectionTitles objectAtIndex:i]objectAtIndex:0]).commonName substringToIndex:1]];
        }
    }
    else
    {
        for(int i = 0; i < [sectionTitles count]; i++)
        {
            [titles addObject:[((Tree *)[[sectionTitles objectAtIndex:i]objectAtIndex:0]).scientName substringToIndex:1]];
        }
    }
    
    return titles;
}
 

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self performSegueWithIdentifier:@"showTreeInfo" sender:self];

}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showTreeInfo"]){
        if(self.searchDisplayController.active){
                [[segue destinationViewController] setTree:[self.filteredTreeArray objectAtIndex:self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow.row]];
        }else{
            [[segue destinationViewController] setTree:[[sectionTitles objectAtIndex:self.tableView.indexPathForSelectedRow.section] objectAtIndex:self.tableView.indexPathForSelectedRow.row ]];
        }
    }
}


-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredTreeArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.commonName contains[c] %@) OR (SELF.scientName contains[c] %@)",searchText, searchText];
    self.filteredTreeArray = [NSMutableArray arrayWithArray:[self.treeArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void) searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setRowHeight:80.0];
}
- (void) searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [tableView setRowHeight:80.0];
}

- (IBAction)segmentChanged:(id)sender{
    if (self.segmentControl.selectedSegmentIndex == 0){
        self.treeArray = [self.treeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *common1 = ((Tree*) obj1).commonName;
            NSString *common2 = ((Tree*) obj2).commonName;
            return [common1 compare:common2];
        }];
        [sectionTitles removeAllObjects];
        NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
        
        NSString *letter, *letter2;
        int j = 0;
        for (int i = 1; i < [self.treeArray count]; i++)
        {
            if([sectionArray count] == 0){
                [sectionArray addObject:[self.treeArray objectAtIndex:0]];
            }
            letter = [((Tree *)[sectionArray objectAtIndex:j]).commonName substringToIndex:1];
            letter2 = [((Tree *)[self.treeArray objectAtIndex:i]).commonName substringToIndex:1];

            if (![letter isEqual:[((Tree *)[self.treeArray objectAtIndex:i]).commonName substringToIndex:1]] ){
                
                [sectionTitles addObject:sectionArray];
                sectionArray = [[NSMutableArray alloc] init];
                j = 0;
            }else{
                j++;
            }
            [sectionArray addObject:[self.treeArray objectAtIndex:i]];
            
        }

    }else{
        self.treeArray = [self.treeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *scient1 = ((Tree*) obj1).scientName;
            NSString *scient2 = ((Tree*) obj2).scientName;
            return [scient1 compare:scient2];
        }];
        
        [sectionTitles removeAllObjects];
        NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
        
        NSString *letter, *letter2;
        int j = 0;
        for (int i = 1; i < [self.treeArray count]; i++)
        {
            if([sectionArray count] == 0){
                [sectionArray addObject:[self.treeArray objectAtIndex:0]];
            }
            letter = [((Tree *)[sectionArray objectAtIndex:j]).scientName substringToIndex:1];
            letter2 = [((Tree *)[self.treeArray objectAtIndex:i]).scientName substringToIndex:1];
            if (![letter isEqual:[((Tree *)[self.treeArray objectAtIndex:i]).scientName substringToIndex:1]] ){
                
                [sectionTitles addObject:sectionArray];
                sectionArray = [[NSMutableArray alloc] init];
                j = 0;
            }else{
                j++;
            }
            [sectionArray addObject:[self.treeArray objectAtIndex:i]];
            
        }

    }
    [self.tableView reloadData];
    
}



@end
