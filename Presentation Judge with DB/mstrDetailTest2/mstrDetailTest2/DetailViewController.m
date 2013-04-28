//
//  DetailViewController.m
//  mstrDetailTest2
//
//  Created by skadoo on 4/22/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import "DetailViewController.h"
#import "Presenter.h"
#import "PresenterDBAccess.h"
#import "Judge.h"
#import "JudgeDBAccess.h"
#import "Presentation.h"
#import "PresentationDBAccess.h"
#import "Presentation.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property( strong, nonatomic) JudgeDBAccess *judgeList;
@property (strong,nonatomic) PresenterDBAccess *presenterList;
@property (strong,nonatomic) PresentationDBAccess *presentationList;

- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) loadSelectedPresentation: (Presentation *) presentation
{
    self.lblPresentationTitle.text = [NSString stringWithFormat:@"Presentation Title: %@",presentation.Title];
    //get Presenter Information
    
    PresenterDBAccess *presenterDB =[[PresenterDBAccess alloc]init];
    //get Presenter
    Presenter *presenter = [presenterDB getPresenterByID:presentation.ID];
    
    self.lblPresenter1Name.text =[NSString stringWithFormat:@"Presenter Name: %@ %@",presenter.FirstName, presenter.LastName];
    self.lblPresenter1Email.text =[NSString stringWithFormat:@"Presenter Email: %@", presenter.Email];
    //get Judge Information
    JudgeDBAccess *judgeDB =[[JudgeDBAccess alloc]init];
    NSMutableArray *judges = [judgeDB getJudgesByPresentationID:presentation.ID];
    Judge *judge1 = judges[0];
    self.lblJudge1Name.text =[NSString stringWithFormat:@"Judge 1 Name: %@ %@", judge1.FirstName,judge1.LastName];
    self.lblJudge1Email.text = [NSString stringWithFormat:@"Judge 1 Email: %@", judge1.Email];
    
    Judge *judge2 = judges[1];
    self.lblJudge2Name.text =[NSString stringWithFormat:@"Judge 2 Name: %@ %@", judge2.FirstName,judge2.LastName];
    self.lblJudge2Email.text = [NSString stringWithFormat:@"Judge 2 Email: %@", judge2.Email];
}
-(PresenterDBAccess *) presenterList
{
    if(!_presenterList)
    {
        _presenterList =[[PresenterDBAccess alloc]init];
    }
    return _presenterList;
}
-(JudgeDBAccess  * ) judgeList
{
    if(!_judgeList)
    {
        _judgeList =[[JudgeDBAccess alloc ]init];
    }
    return  _judgeList;
}
-(PresentationDBAccess *) presentationList
{
    if(!_presentationList)
    {
        _presentationList = [[PresentationDBAccess alloc]init];
    }
    return _presentationList;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
