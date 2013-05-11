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

static NSMutableString *judEmail1 = nil;
static NSMutableString *judEmail2 = nil;
static NSMutableString *presName = nil;
static NSMutableString *presTitle = nil;
static int totPoints = 0;
static int gotPoints = 0;


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
    
    self.gavelImage.hidden = TRUE;
    self.instructionsView.hidden = TRUE;
    self.lblPresentationTitle.text = [NSString stringWithFormat:@"Presentation Title: %@",presentation.Title];
    
    presTitle = presentation.Title;
    
    //get Presenter Information
    
    PresenterDBAccess *presenterDB =[[PresenterDBAccess alloc]init];
    //get Presenter
    Presenter *presenter = [presenterDB getPresenterByID:presentation.ID];
    
    self.lblPresenter1Name.text =[NSString stringWithFormat:@"Presenter Name: %@ %@",presenter.FirstName, presenter.LastName];
    self.lblPresenter1Email.text =[NSString stringWithFormat:@"Presenter Email: %@", presenter.Email];
    
    presName = [NSMutableString stringWithFormat:@"%@ %@", presenter.FirstName, presenter.LastName];
    
    //get Judge Information
    JudgeDBAccess *judgeDB =[[JudgeDBAccess alloc]init];
    NSMutableArray *judges = [judgeDB getJudgesByPresentationID:presentation.ID];
    Judge *judge1 = judges[0];
    self.lblJudge1Name.text =[NSString stringWithFormat:@"Judge 1 Name: %@ %@", judge1.FirstName,judge1.LastName];
    self.lblJudge1Email.text = [NSString stringWithFormat:@"Judge 1 Email: %@", judge1.Email];
    
    judEmail1 = judge1.Email;
    
    Judge *judge2 = judges[1];
    self.lblJudge2Name.text =[NSString stringWithFormat:@"Judge 2 Name: %@ %@", judge2.FirstName,judge2.LastName];
    self.lblJudge2Email.text = [NSString stringWithFormat:@"Judge 2 Email: %@", judge2.Email];
    
    judEmail2 = judge2.Email;
}

- (IBAction)openMail:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *subj = [NSString stringWithFormat: @"Presentation Judge Results: %@", presName];
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject: subj];
        NSArray *toRecipients = [NSArray arrayWithObjects: judEmail1, judEmail2, nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = [NSString stringWithFormat: @"Results for %@ on his presentation titled %@: \n\n Out of a possible %i points, %@ received a score of %i.", presName, presTitle, totPoints, presName, gotPoints];
        [mailer setMessageBody:emailBody isHTML:NO];
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:nil];
        
    }
    else
    { //for when the email doesn't work
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        

}
}

//handling errors
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    { //responses
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
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
    barButtonItem.title = NSLocalizedString(@"Assigned Presentations", @"Assigned Presentation");
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
