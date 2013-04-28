//
//  CategoryViewController.h
//  mstrDetailTest2
//
//  Created by skadoo on 4/24/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryDelegate <NSObject>

-(void) setPresentationID :(int) presentationID;

@end
@interface CategoryViewController : UITableViewController

@property (nonatomic,assign) id<CategoryDelegate> delegate;
@property (nonatomic,assign) NSInteger presentationID;
@end