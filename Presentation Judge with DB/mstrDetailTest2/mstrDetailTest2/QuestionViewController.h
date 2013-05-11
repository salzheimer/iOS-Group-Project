//
//  QuestionViewController.h
//  mstrDetailTest2
//
//  Created by skadoo on 4/29/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboBox.h"
@class QuestionViewController;

@interface QuestionViewController : UIViewController<UISplitViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
  NSMutableArray *rankingElements ;
    UIPickerView *pvRanking;
    ComboBox *combo1;
    ComboBox *combo2;
    ComboBox *combo3;
    ComboBox *combo4;
    ComboBox *combo5;
   // UITextField *txtComments;
}
-(void) loadQuestionsForSection;

@property (strong, nonatomic) id detailItem;


@property (nonatomic,assign) NSInteger SectionID;
@property (nonatomic,assign) NSInteger PresentationID;
@property (nonatomic, retain) UIPickerView *pvRanking;
@property (nonatomic, retain) NSMutableArray *rankingElements;
@property (nonatomic,strong) UITextField *txtComments;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
