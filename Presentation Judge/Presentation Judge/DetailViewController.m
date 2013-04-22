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
