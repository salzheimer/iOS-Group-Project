//
//  DetailViewController.m
//  Presentation Judge
//
//  Created by Eden on 4/7/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//THIS IS WHAT HAPPENS WHEN A SELECTION IS MADE IN THE PRESENTATION TABLE

//pulling up the email dialogue
- (IBAction)openMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Presentation Judge: Test Test!"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"lemalenfant@gmail.com", @"lauren-malenfant@uiowa.edu", nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = @"Test, test!";
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
//the email composer
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    { //working with drafts, etc
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
    // Remove the mail view
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void) didSelectPresentation:(AssignedPresentations *)presentation{
    
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected Presentation" message:presentation.presentationTitle delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    //[alert show];
    
    self.presentationLabel.text = presentation.presentationTitle;
    
    self.presentationTitleLabel.text = [NSString stringWithFormat:@"Presentation Name: %@", presentation.presentationTitle];
    self.presenterName.text = [NSString stringWithFormat:@"Presenter Name: %@", presentation.presenterName];
    self.presenterEmail.text = [NSString stringWithFormat:@"Presenter Email: %@", presentation.presenterEmail];
    self.judgeName.text = @"Judge Name: Eden Englert";
    self.judgeEmail.text = @"Judge Email: eenglert@uiowa.edu";

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    barButtonItem.title = @"Presentations";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    
    masterPopoverController = pc;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button{

    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObject:button];
    [self.toolbar setItems:items animated:YES];
    masterPopoverController = nil;
    
}

@end
