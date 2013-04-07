//
//  MasterTableViewController.m
//  Presentation Judge
//
//  Created by Eden on 4/7/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "MasterTableViewController.h"
#import "AssignedPresentations.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

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
    
    presentationTitles = [[NSMutableArray alloc] init];
    
    AssignedPresentations *pres1 = [[AssignedPresentations alloc] init];
    pres1.presentationTitle = @"How to Blow Your Nose";
    pres1.presenterName = @"Ron Burgundy";
    
    AssignedPresentations *pres2 = [[AssignedPresentations alloc] init];
    pres2.presentationTitle = @"How to Make a PB&J Sandwich";
    pres2.presenterName = @"Will Ferrell";
    
    AssignedPresentations *pres3 = [[AssignedPresentations alloc] init];
    pres3.presentationTitle = @"How to Save the World";
    pres3.presenterName = @"Ironman";
    
    AssignedPresentations *pres4 = [[AssignedPresentations alloc] init];
    pres4.presentationTitle = @"How to Make KFC Chicken";
    pres4.presenterName = @"The Colonel";
    
    AssignedPresentations *pres5 = [[AssignedPresentations alloc] init];
    pres5.presentationTitle = @"How to Golf 1";
    pres5.presenterName = @"Happy Gilmore";
    
    AssignedPresentations *pres6 = [[AssignedPresentations alloc] init];
    pres6.presentationTitle = @"How to Golf 2";
    pres6.presenterName = @"Charles Barkley";
    
    AssignedPresentations *pres7 = [[AssignedPresentations alloc] init];
    pres7.presentationTitle = @"How to Get the Force";
    pres7.presenterName = @"Obi-Wan Kenobi";
    
    AssignedPresentations *pres8 = [[AssignedPresentations alloc] init];
    pres8.presentationTitle = @"How to Build Bunkbeds Without Power Tools";
    pres8.presenterName = @"Brennan Huff and Dale Doback";
    
    [presentationTitles addObject:pres1];
    [presentationTitles addObject:pres2];
    [presentationTitles addObject:pres3];
    [presentationTitles addObject:pres4];
    [presentationTitles addObject:pres5];
    [presentationTitles addObject:pres6];
    [presentationTitles addObject:pres7];
    [presentationTitles addObject:pres8];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [presentationTitles count];
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"presentationCell";
    
    AssignedPresentations *assignedPresentations = [presentationTitles objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //cell.textLabel.text = [self getMyDataForRow:indexPath.row inSection:indexPath.section];
    
    [[cell textLabel] setText:assignedPresentations.presentationTitle];
    [[cell detailTextLabel] setText:assignedPresentations.presenterName];

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
