//
//  PreseantationQuestionsDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "PreseantationQuestionsDBAccess.h"
#import "PresentationQuestion.h"    
@implementation PreseantationQuestionsDBAccess
-(NSMutableArray *) getPresentationQuestions
{
    NSMutableArray *preseantationQuestionArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& pqDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,PresentationID,QuestionSectionID from PresentationQuestion";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(pqDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            PresentationQuestion *newSectionQuestion = [[PresentationQuestion alloc]init];
            newSectionQuestion.ID = sqlite3_column_int(sqlStatment,0);
            newSectionQuestion.PresentationID  = sqlite3_column_int(sqlStatment,1);
            newSectionQuestion.QuestionSectionID =sqlite3_column_int(sqlStatment,2);
                        
            [preseantationQuestionArray addObject:newSectionQuestion];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return preseantationQuestionArray;
    }
    


}
@end
