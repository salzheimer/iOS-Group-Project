//
//  QuestionViewController.h
//  mstrDetailTest2
//
//  Created by skadoo on 4/29/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController<UISplitViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
  NSMutableArray *rankingElements ;
    UIPickerView *pvRanking;
}
-(void) loadQuestionsForSection;//:(int) sectionID;

@property (strong, nonatomic) id detailItem;

@property (nonatomic,assign) NSInteger SectionID;
@property (nonatomic,assign) NSInteger PresentationID;
@property (nonatomic, retain) UIPickerView *pvRanking;
@property (nonatomic, retain) NSMutableArray *rankingElements;


@end
