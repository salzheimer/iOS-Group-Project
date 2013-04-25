//
//  DetailViewController.h
//  Presentation Judge
//
//  Created by Eden on 4/7/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterTableViewController.h"
#import <MessageUI/MessageUI.h>

//responsible for adding different events
@interface DetailViewController : UIViewController<UISplitViewControllerDelegate, PresentationDelegate, MFMailComposeViewControllerDelegate>{
    UIPopoverController *masterPopoverController;
}
//the email button
- (IBAction)openMail:(id)sender;

- (void) didSelectPresentation:(AssignedPresentations *)presentation;

@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UILabel *presentationLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *presenterName;
@property (weak, nonatomic) IBOutlet UILabel *presenterEmail;
@property (weak, nonatomic) IBOutlet UILabel *judgeName;
@property (weak, nonatomic) IBOutlet UILabel *judgeEmail;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextPage;


@end
