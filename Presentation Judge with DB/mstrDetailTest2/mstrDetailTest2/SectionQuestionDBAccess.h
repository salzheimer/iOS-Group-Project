//
//  SectionQuestionDBAccess.h
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface SectionQuestionDBAccess : NSObject
{
    sqlite3 *sqDB;
}
-(NSMutableArray *) getPresentationSections;
-(NSMutableArray *) getSectionQuestionsByPresentationID: (int) presentationID;
-(NSInteger) countSectionsByPresentationID:(int) presentationID;
-(NSMutableArray *) getSectionQuestionsBySectionID: (int) sectionID;
@end
