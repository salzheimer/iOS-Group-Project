//
//  PresentationDBAccess.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface PresentationDBAccess : NSObject
{
    sqlite3 *PresentationDB;
    
}
-(NSMutableArray *) getPresentations;
@end
