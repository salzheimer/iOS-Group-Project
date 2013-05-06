//
//  SectionDBAccess.h
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Section.h"

@interface SectionDBAccess : NSObject
{
    sqlite3 *SectionDB;
}
-(NSMutableArray *)getSections;
-(Section *) getSectionsBySectionID:(int) sectionID;
-(NSMutableArray *)getSectionsByPresentationID:(int) presentationID;
-(NSInteger) getSectionCountByPresentationID:(int) presentationID;
-(NSString *) getPresentation_SectionNameForIndex: (int) index presentationID:(int) presentationID;
-(Section *) getPresentation_SectionForIndex: (int) index presentationID:(int) presentationID;

@end
