//
//  PreseantationQuestionsDBAccess.h
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface PresentationQuestionsDBAccess : NSObject
{
    sqlite3 *pqDB;
}
-(NSMutableArray *) getPresentationQuestions;
-(NSMutableArray *) getPresentationQuestions: (int) presentationID;
-(NSInteger) getQuestionSectionIDByPresentationID: (int) presentationID;
@end
