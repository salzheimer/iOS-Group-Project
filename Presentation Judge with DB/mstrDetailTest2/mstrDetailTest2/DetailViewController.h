//
//  DetailViewController.h
//  mstrDetailTest2
//
//  Created by skadoo on 4/22/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Presentation.h"
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

-(void) loadSelectedPresentation: (Presentation *) presentation;

@property (strong, nonatomic) id detailItem;

@property  (weak,nonatomic) IBOutlet UILabel *lblPresentationTitle;
@property (weak,nonatomic) IBOutlet UILabel *lblPresenter1Name;
@property (weak,nonatomic) IBOutlet UILabel *lblPresenter1Email;
@property (weak,nonatomic) IBOutlet UILabel *lblPresenter2Name;
@property (weak,nonatomic) IBOutlet UILabel *lblPresenter2Email;
@property (weak,nonatomic) IBOutlet UILabel *lblJudge1Name;
@property (weak,nonatomic) IBOutlet UILabel *lblJudge1Email;
@property (weak,nonatomic) IBOutlet UILabel *lblJudge2Name;
@property (weak,nonatomic) IBOutlet UILabel *lblJudge2Email;
@property (weak, nonatomic) IBOutlet UIImageView *gavelImage;
@property (weak, nonatomic) IBOutlet UITextView *instructionsView;

@end
