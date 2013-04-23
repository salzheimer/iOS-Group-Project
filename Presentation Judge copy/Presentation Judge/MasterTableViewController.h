//
//  MasterTableViewController.h
//  Presentation Judge
//
//  Created by Eden on 4/7/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssignedPresentations.h"

@protocol PresentationDelegate <NSObject>

-(void) didSelectPresentation:(AssignedPresentations *) presentation;

@end

@interface MasterTableViewController : UITableViewController{

    NSMutableArray *presentationTitles;
}

@property (nonatomic, strong) id<PresentationDelegate> delegate;

@end
