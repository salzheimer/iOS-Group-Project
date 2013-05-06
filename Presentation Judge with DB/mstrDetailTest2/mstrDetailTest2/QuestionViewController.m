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

@interface QuestionViewController ()

@end

@implementation QuestionViewController

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
}
-(void) loadQuestionsForSection:(int) sectionID
{
    SectionQuestionDBAccess * secQuestions =[[SectionQuestionDBAccess alloc]init];
    QuestionDBAccess *questionDB =[[QuestionDBAccess alloc]init];
    SubSectionDBAccess *subSectionDB =[[SubSectionDBAccess alloc]init];
    NSMutableArray *questions= [secQuestions getSectionQuestionsBySectionID:sectionID];
    
    for(int i=0;i<questions.count;i++)
    {
        SectionQuestion * q = questions[i];
        Question *currentQuestion = [questionDB getQuestionByID:q.QuestionID];
        SubSection *subSection = [subSectionDB getSubSectionByID: q.SubSectionID];
        
        UILabel *lblSubSection = [[UILabel alloc]init];
        UILabel *lblQuestion = [[UILabel alloc]init];
        lblQuestion.text = currentQuestion.Question;
        lblSubSection.text = subSection.SubSection_Name;
        [self.view addSubview:lblSubSection];
        [self.view addSubview:lblQuestion];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
