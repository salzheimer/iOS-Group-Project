//
//  MasterViewController.m
//  mstrDetailTest2
//
//  Created by skadoo on 4/22/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PresentationDBAccess.h"
#import "PresentationPresenter.h"
#import "Presenter.h"
#import "PresenterDBAccess.h"
#import "CategoryViewController.h"

@interface MasterViewController ()  <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) PresentationDBAccess *presentationList;

@property(nonatomic,retain) NSMutableArray *presArray;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 - (void)insertNewObject:(id)sender
 {
 if (!_objects) {
 _objects = [[NSMutableArray alloc] init];
 }
 [_objects insertObject:[NSDate date] atIndex:0];
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
 [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
 }*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionCell" forIndexPath:indexPath];
    NSInteger cellNum = indexPath.row;

    //get presentation
    Presentation *pres =[self.presentationList getPresentationForIndex:cellNum];
    
    //get presentation Id
    NSInteger presID = [self.presentationList getPresenterIDByPresentationID:pres.ID];
    
    PresenterDBAccess *presenterDB =[[PresenterDBAccess alloc]init];
    //get Presenter
    Presenter *presenter = [presenterDB getPresenterByID:presID];
    //set Title label
    cell.textLabel.text = [self.presentationList presentationTitleForIndex:cellNum];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@", presenter.FirstName , presenter.LastName];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presentationList  presentationCount];
}

/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 [_objects removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }
 } */

-(PresentationDBAccess *) presentationList
{
    if(!_presentationList)
    {
        _presentationList = [[PresentationDBAccess alloc]init];
    }
    return _presentationList;
}



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

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     NSInteger cellNum = indexPath.row;
     
     //get presentation
     Presentation *pres =[self.presentationList getPresentationForIndex:cellNum];
     
     [self.detailViewController loadSelectedPresentation:pres];
 
 }

//prepare to move to next mater view using segue
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     
     if ([[segue identifier] isEqualToString:@"CategorySegue"])
     {
         //get presentation
         Presentation *pres =[self.presentationList getPresentationForIndex:indexPath.row];
         CategoryViewController *catView = (CategoryViewController *)[segue destinationViewController];
         catView.presentationID = pres.ID;
        
     }
 
 }
@end
