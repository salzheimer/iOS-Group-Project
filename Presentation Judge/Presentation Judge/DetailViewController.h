//
//  DetailViewController.h
//  Presentation Judge
//
//  Created by Eden on 4/7/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <UIKit/UIKit.h>


//responsible for adding different events
@interface DetailViewController : UIViewController<UISplitViewControllerDelegate>{
    UIPopoverController *masterPopoverController;
    
}
@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;

@end
