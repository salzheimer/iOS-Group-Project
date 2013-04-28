//
//  MasterViewController.h
//  mstrDetailTest2
//
//  Created by skadoo on 4/22/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class CategoryViewController;
@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong,nonatomic) CategoryViewController *categoryViewController;
@end

