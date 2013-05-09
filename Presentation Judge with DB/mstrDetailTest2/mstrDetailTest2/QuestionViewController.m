//
//  QuestionViewController.m
//  mstrDetailTest2
//
//  Created by skadoo on 4/29/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import "QuestionViewController.h"
#import "SectionQuestionDBAccess.h"
#import "SectionQuestion.h"
#import "SubSection.h"
#import "SubSectionDBAccess.h"
#import "Question.h"
#import "QuestionDBAccess.h"
#import "RankStyle.h"
#import "RankStyleDBAccess.h"
#import "Presentation.h"
#import "PresentationDBAccess.h"

@interface QuestionViewController ()


@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation QuestionViewController
@synthesize SectionID;
@synthesize PresentationID;
@synthesize pvRanking;
@synthesize rankingElements;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
    [self loadQuestionsForSection];
     rankingElements =[[NSMutableArray alloc]init];
}
-(void) loadQuestionsForSection//:(int) sectionID
{
    SectionQuestionDBAccess * secQuestions =[[SectionQuestionDBAccess alloc]init];
    QuestionDBAccess *questionDB =[[QuestionDBAccess alloc]init];
    SubSectionDBAccess *subSectionDB =[[SubSectionDBAccess alloc]init];
    PresentationDBAccess *presDB =[[PresentationDBAccess alloc]init];
    Presentation *pres= [presDB getPresentationByID:PresentationID];
    NSInteger lowerBound =[pres.ScaleLowerBound intValue];
    NSInteger upperBound=[pres.ScaleUpperBound intValue];
   
    
    for(NSInteger i=lowerBound; i< upperBound;i++)
    {
       [rankingElements  addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    
    NSMutableArray *questions= [secQuestions getSectionQuestionsBySectionID:SectionID];
    
    for(int i=0;i<1/*questions.count*/;i++)
    {
        SectionQuestion * q = questions[i];
        Question *currentQuestion = [questionDB getQuestionByID:q.QuestionID];
        SubSection *subSection = [subSectionDB getSubSectionByID: q.SubSectionID];
        
        
        
        //Subsection label
        UILabel *lblSubSection = [[UILabel alloc] initWithFrame:CGRectMake(10, (i*60)+10, 250, 20)];
        [lblSubSection setText:[NSString stringWithFormat:@"%@:",subSection.SubSection_Name]];
        [lblSubSection setTextColor:[UIColor blackColor]];
        
        //Question
        UILabel *lblQuestion = [[UILabel alloc]initWithFrame:CGRectMake(100, (i*60)+40, 400, 20)];
        
        UIPickerView *pvRating =[[UIPickerView alloc] initWithFrame:CGRectMake(500, (i*60)+40, 160.0, 160.0)];
        // Set the delegate and datasource. Don't expect picker view to work
        // correctly if you don't set it.
        [pvRanking setDataSource:self];
        [pvRanking setDelegate:self];
        [lblQuestion setText:currentQuestion.Question];
        [lblQuestion setTextColor:[UIColor blackColor]];
        
        [self.view addSubview:lblSubSection];
        [self.view addSubview:lblQuestion];
        [self.view addSubview:pvRating];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pvRanking numberOfRowsInComponent:(NSInteger)component{
    PresentationDBAccess *presDB =[[PresentationDBAccess alloc]init];
    Presentation *pres= [presDB getPresentationByID:PresentationID];
    NSInteger lowerBound =[pres.ScaleLowerBound intValue];
    NSInteger upperBound=[pres.ScaleUpperBound intValue];
    NSInteger itemCount= lowerBound -upperBound;
    return itemCount;
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pvRanking titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [rankingElements objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pvRanking didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"You selected this: %@", [rankingElements objectAtIndex: row]);
}
/*
-(UIView *)pickerView:(UIPickerView *)pvRanking viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    // Get the text of the row.
    NSString *rowItem = [rankingElements objectAtIndex: row];
    
    // Create and init a new UILabel.
    // We must set our label's width equal to our picker's width.
    // We'll give the default height in each row.
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pvRanking bounds].size.width, 44.0f)];
    
    // Center the text.
    [lblRow setTextAlignment:UITextAlignmentCenter];
    
    // Make the text color red.
    [lblRow setTextColor: [UIColor redColor]];
    
    // Add the text.
    [lblRow setText:rowItem];
    
    // Clear the background color to avoid problems with the display.
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    // Return the label.
    return lblRow;
}*/
@end
