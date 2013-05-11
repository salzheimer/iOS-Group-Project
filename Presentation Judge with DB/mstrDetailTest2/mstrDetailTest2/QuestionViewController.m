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
#import "ComboBox.h"
#import "QuestionRanking.h"
#import "QuestionRankingDBAccess.h"

@interface QuestionViewController ()


@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation QuestionViewController
@synthesize SectionID;
@synthesize PresentationID;
@synthesize pvRanking;
@synthesize rankingElements;
@synthesize txtComments;

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
    rankingElements =[[NSMutableArray alloc]init];
    
    for(NSInteger i=lowerBound; i< upperBound+1;i++)
    {
       
     NSString *element =  [NSString stringWithFormat:@"%d",i];
       [rankingElements  addObject:element];
    }
       
    NSMutableArray *questions= [secQuestions getSectionQuestionsBySectionID:SectionID];
    
    for(int i=0;i<questions.count;i++)
    {
        SectionQuestion * q = questions[i];
        Question *currentQuestion = [questionDB getQuestionByID:q.QuestionID];
        SubSection *subSection = [subSectionDB getSubSectionByID: q.SubSectionID];
 
       
        
        //Subsection label
        UILabel *lblSubSection = [[UILabel alloc] initWithFrame:CGRectMake(10, (i*70)+10, 250, 20)];
        [lblSubSection setText:[NSString stringWithFormat:@"%@:",subSection.SubSection_Name]];
        [lblSubSection setTextColor:[UIColor blackColor]];
        
        //Question
        UILabel *lblQuestion = [[UILabel alloc]initWithFrame:CGRectMake(100, (i*70)+40, 400, 20)];
        [lblQuestion setText:currentQuestion.Question];
        [lblQuestion setTextColor:[UIColor blackColor]];
        lblQuestion.numberOfLines =1;
        [lblQuestion setLineBreakMode:NSLineBreakByCharWrapping];
        [lblQuestion setAdjustsFontSizeToFitWidth:TRUE];
       
        if([lblSubSection.text  rangeOfString: @"Comments"].location == NSNotFound)
       {
           //add controls to view
           [self.view addSubview:lblSubSection];
           [self.view addSubview:lblQuestion];

            //ranking boxes
            switch (i) {
                case 0:
                    combo1 =[[ComboBox alloc]init];
                    [combo1 setComboData:rankingElements];
                    [self.view addSubview:combo1.view];
                    combo1.view.frame = CGRectMake(500, (i*60)+40, 90.0, 30.0);
                    break;
                case 1:
                    combo2 =[[ComboBox alloc]init];
                    [combo2 setComboData:rankingElements];
                    [self.view addSubview:combo2.view];
                    combo2.view.frame = CGRectMake(500, (i*60)+40, 90.0, 30.0);
                    break;
                case 2:
                    combo3 =[[ComboBox alloc]init];
                    [combo3 setComboData:rankingElements];
                    [self.view addSubview:combo3.view];
                    combo3.view.frame = CGRectMake(500, (i*60)+40, 90.0, 30.0);
                    break;
                case 3:
                    combo4 =[[ComboBox alloc]init];
                    [combo4 setComboData:rankingElements];
                    [self.view addSubview:combo4.view];
                    combo4.view.frame = CGRectMake(500, (i*60)+40, 90.0, 30.0);
                    break;
                case 4:
                    combo5 =[[ComboBox alloc]init];
                    [combo5 setComboData:rankingElements];
                    [self.view addSubview:combo5.view];
                    combo5.view.frame = CGRectMake(500, (i*60)+40, 90.0, 30.0);
                    break;
                default:
                    break;
        }
       }
        else if ([lblSubSection.text rangeOfString:@"Comments" ].location != NSNotFound)
        {
            //add textbox for comments
            self.txtComments = [[UITextField alloc]initWithFrame:CGRectMake(10, (i*70)+40, 500.0, 200.0)];
           
            self.txtComments.keyboardType = UIKeyboardAppearanceDefault;
            self.txtComments.borderStyle = UITextBorderStyleRoundedRect;
            
            
            //add controls to view
            [self.view addSubview:lblSubSection];
            [self.view addSubview:lblQuestion];
            [self.view addSubview:txtComments];
            
        }
        
             

    }
}

- (IBAction)SaveRatings:(id)sender
{
    NSArray *views =  [self.view subviews];
    QuestionRankingDBAccess *qRankingDb =[[QuestionRankingDBAccess alloc]init];
    SectionQuestionDBAccess * secQuestions =[[SectionQuestionDBAccess alloc]init];
    NSMutableArray *questions= [secQuestions getSectionQuestionsBySectionID:SectionID];
    for(int i=0;i<questions.count;i++)
    {
        NSString *ranking;
        switch (i) {
            case 0:
                ranking = combo1.selectedText;
                break;
            case 1:
                ranking = combo2.selectedText;
                break;
            case 2:
                ranking = combo3.selectedText;
                break;
            case 3:
                ranking = combo4.selectedText;
                break;
            case 4:
                ranking = combo5.selectedText;
                break;
            default:
                break;
        }

        SectionQuestion *q = questions[i];
        QuestionRanking *qRanking=[[QuestionRanking alloc]init];
        qRanking.PresentationID = PresentationID;
        qRanking.QuestionID =q.QuestionID;
        qRanking.Ranking = ranking;
        [qRankingDb SavePresentationRanking:qRanking];
        
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
   return rankingElements.count;
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pvRanking titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [rankingElements objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pvRanking didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"You selected this: %@", [rankingElements objectAtIndex: row]);
}

- (void)questionViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)questionViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


@end
