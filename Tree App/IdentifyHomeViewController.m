//
//  IdentifyHomeViewController.m
//  Tree App
//
//  Created by Bria Sullivan on 5/7/13.
//  Copyright (c) 2013 Matt Ritter. All rights reserved.
//

#import "IdentifyHomeViewController.h"
#import "HomeCell.h"

@interface IdentifyHomeViewController (){
    NSMutableArray *nameArray;
}

@end

@implementation IdentifyHomeViewController
@synthesize binTree = _binTree;
@synthesize keyArray = _keyArray;


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
    NSString *newpath = [[NSBundle mainBundle] pathForResource:@"identifydata" ofType:@"txt"];
    self.binTree = [[BinTree alloc] initWithContentsOfFile:newpath];
    self.keyArray = self.binTree.keyNodes;
    nameArray = [[NSMutableArray alloc] init];
    NSDictionary *tempDict;
    for(int i = 0; i < [self.binTree.keyNames count]; i++){
        tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:((NSString*)[self.binTree.keyNames objectAtIndex:i]), @"name", [NSString stringWithFormat:@"%d", i ], @"id",nil];
        [nameArray addObject:tempDict ];
        //[nameArray addObject:[[NSDictionary alloc]initWithObjectsAndKeys: ];
    }
    nameArray = [[NSMutableArray alloc] initWithArray:[nameArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = [obj1 objectForKey:@"name"];
        NSString *name2 = [obj2 objectForKey:@"name"];
        return [name1 compare:name2];
    }]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setCustomTitle:@"Tree Guru"];
    UIImage *unselectedImage = [[UIImage imageNamed:@"SegmentedController.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *selectedImage = [[UIImage imageNamed:@"SegmentedControllerSelected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
   // [UIImage imageNamed:@""] res
    //UIImage *unselectedImage = [UIImage imageNamed:@"SegmentedController.png"];
    //UIImage *selectedImage = [UIImage imageNamed:@"SegmentedControllerSelected.png"] ;
    [[UISegmentedControl appearance] setBackgroundImage:unselectedImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //[[UISegmentedControl appearance] setImage:selectedImage forSegmentAtIndex:0];
    
    
    [[UISegmentedControl appearance] setBackgroundImage:selectedImage
                                               forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    //[[UISegmentedControl appearance] setDividerImage:nil forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
   
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    if(self.control.selectedSegmentIndex == 0)
    {
        if ([[ UIScreen mainScreen ] bounds ].size.height == 480)
        {
            self.tableView.scrollEnabled = YES;
            
        }
        else
            self.tableView.scrollEnabled = NO;
    }
    else
        self.tableView.scrollEnabled = YES;
    

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
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"What best describes your tree?";
}
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 34)]; // x,y,width,height
    if (!self.control){
        NSArray *itemArray = [NSArray arrayWithObjects: @"All Trees", @"Identify By Tree Type", nil];
        self.control = [[UISegmentedControl alloc] initWithItems:itemArray];
        //[self.control setTintColor:[UIColor clearColor]];
        [self.control setTitle:@"All Trees" forSegmentAtIndex:0];
        [self.control setFrame:CGRectMake(0, 0, 320.0, 34.0)];
        [self.control setBackgroundColor:[UIColor clearColor]];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:12], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil];
        [self.control setTitleTextAttributes:attributes forState:UIControlStateNormal];

       // [self.control setSelected:UISegmentedControlNoSegment];
        [self.control setSelectedSegmentIndex:0];
        [self.control setEnabled:YES];
        [self.control setContentMode:UIViewContentModeScaleAspectFill];
        [self.control addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    [headerView addSubview:self.control];

    return headerView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(self.control.selectedSegmentIndex == 0){
        return 4;
    }
    return [self.binTree.keyNames count];
}
- (IBAction)changeSegment:(id)sender
{
    if(self.control.selectedSegmentIndex == 0)
    {
        if ([[ UIScreen mainScreen ] bounds ].size.height == 480)
        {
            self.tableView.scrollEnabled = YES;
            
        }
        else
            self.tableView.scrollEnabled = NO;
        
        
    }
    else
        self.tableView.scrollEnabled = YES;
    
    
    [self.tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (HomeCell *) [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil]objectAtIndex:0];
    }

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    [imgView setImage:[UIImage imageNamed:@"PrimaryCellBackgroundImage.png"]];
    //cell.contentView.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:imgView];
    if(self.control.selectedSegmentIndex == 0){
        // Configure the cell...
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        switch (indexPath.row) {
            case 0:
                cell.plainLabel.text = @"Broad-leaved trees";
                cell.nodeImgView.image = [UIImage imageNamed:@"broadleaves.png"];
                [cell.nodeImgView setContentMode:UIViewContentModeScaleAspectFit];
                [cell.nodeImgView setHidden:NO];

                break;
            case 1:
                cell.plainLabel.text = @"Conifers or leaves absent/minute";
                cell.nodeImgView.image = [UIImage imageNamed:@"conifers.png"];
                [cell.nodeImgView setContentMode:UIViewContentModeScaleAspectFit];
                [cell.nodeImgView setHidden:NO];

                break;
            case 2:
                cell.plainLabel.text = @"Palms";
                cell.nodeImgView.image = [UIImage imageNamed:@"palms.png"];
                [cell.nodeImgView setContentMode:UIViewContentModeScaleAspectFit];
                [cell.nodeImgView setHidden:NO];

                break;
            case 3:
                cell.plainLabel.text = @"Palm-like trees with long sword-shaped leaves (>8'' long) ";
                cell.nodeImgView.image = [UIImage imageNamed:@"palm-like.png"];
                [cell.nodeImgView setContentMode:UIViewContentModeScaleAspectFit];
                [cell.nodeImgView setHidden:NO];
                break;
                
            default:
                break;
        }
        /*cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        [cell.textLabel setNumberOfLines:0];
*/
        [cell.topLabel setHidden:YES];
        [cell.bottomLabel setHidden:YES];
        [cell.plainLabel setHidden:NO];
        [cell.contentView bringSubviewToFront:cell.plainLabel];
        [cell.contentView bringSubviewToFront:cell.nodeImgView];

    }
    else
    {
        [cell.nodeImgView setHidden:YES];
        NSString *textString = [[nameArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.topLabel.text = [textString substringFromIndex:27];
        NSString *checkString = cell.topLabel.text;
        if([cell.topLabel.text rangeOfString:@","].location!= NSNotFound){
            checkString = [checkString substringToIndex:[checkString rangeOfString:@","].location];
        }
        /*cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.textLabel setNumberOfLines:0];
        cell.detailTextLabel.text = @"spp";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];*/
        cell.bottomLabel.text = [self.binTree findSppWithName:checkString];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.topLabel setHidden:NO];
        [cell.bottomLabel setHidden:NO];
        [cell.plainLabel setHidden:YES];
        [cell.contentView bringSubviewToFront:cell.topLabel];
        [cell.contentView bringSubviewToFront:cell.bottomLabel];
    }
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    CGFloat red = 112.0/255.0;
    CGFloat green = 156.0/255.0;
    CGFloat blue = 25.0/255.0;
    [bgview setBackgroundColor:[UIColor colorWithRed:red
                                               green:green
                                                blue:blue
                                               alpha:8.0]];
    cell.selectedBackgroundView = bgview;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105.0;
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
    IdentifyChoiceViewController *ivc = [[IdentifyChoiceViewController alloc] initWithNibName:@"IdentifyChoiceViewController" bundle:[NSBundle mainBundle]];
    if([self.control selectedSegmentIndex] == 0){
    switch (indexPath.row) {
        case 0:
            ivc.binTree = self.binTree.broadLeaved;
            break;
        case 1:
            ivc.binTree = self.binTree.conifers;
            break;
        case 2:
            ivc.binTree = self.binTree.palms;
            break;
        case 3:
            ivc.binTree = self.binTree.palm_like;
            break;
            
        default:
            break;
            
    }
    }else{
        ivc.binTree = [self.keyArray objectAtIndex:[[[nameArray objectAtIndex:indexPath.row] objectForKey:@"id"]intValue]];
    }
    [self.navigationController pushViewController:ivc animated:YES];
}

@end
