//
//  PrensenterDBAccess.h
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface PresenterDBAccess : NSObject
{
    sqlite3 *presenterDB;
}
-(NSMutableArray *) getPresenters;
@end
