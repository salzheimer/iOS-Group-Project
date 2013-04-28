//
//  PreseantationQuestionsDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "PresentationQuestionsDBAccess.h"
#import "PresentationQuestion.h"   


@implementation PresentationQuestionsDBAccess
-(NSMutableArray *) getPresentationQuestions
{
    NSMutableArray *presentationQuestionArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& pqDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to db.");
        }
        const char *sql= "Select id,PresentationID,QuestionSectionID from PresentationQuestion";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(pqDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select all presentation questions statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            PresentationQuestion *newSectionQuestion = [[PresentationQuestion alloc]init];
            newSectionQuestion.ID = sqlite3_column_int(sqlStatment,0);
            newSectionQuestion.PresentationID  = sqlite3_column_int(sqlStatment,1);
            newSectionQuestion.QuestionSectionID =sqlite3_column_int(sqlStatment,2);
                        
            [presentationQuestionArray addObject:newSectionQuestion];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return presentationQuestionArray;
    }
    


}
-(NSMutableArray *) getPresentationQuestions: (int) presentationID
{
    NSMutableArray *presentationQuestionArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& pqDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to presentation questiondb.");
        }
         NSString *sql = [NSString stringWithFormat:@"Select id,PresentationID,QuestionSectionID from PresentationQuestions where PresentationID = %d", presentationID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(pqDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select presentation questions by presentationid  statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            PresentationQuestion *newSectionQuestion = [[PresentationQuestion alloc]init];
            newSectionQuestion.ID = sqlite3_column_int(sqlStatment,0);
            newSectionQuestion.PresentationID  = sqlite3_column_int(sqlStatment,1);
            newSectionQuestion.QuestionSectionID =sqlite3_column_int(sqlStatment,2);
            
            [presentationQuestionArray addObject:newSectionQuestion];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return presentationQuestionArray;
    }
    
    
}
-(NSInteger) getQuestionSectionIDByPresentationID: (int) presentationID
{
    PresentationQuestion *newSectionQuestion = [[PresentationQuestion alloc]init];
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& pqDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to presentation questiondb.");
        }
         NSString *sql = [NSString stringWithFormat:@"Select id,PresentationID,QuestionSectionID from PresentationQuestion where PresentationID= %d",presentationID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(pqDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select question section by presnetationid statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
           
            newSectionQuestion.ID = sqlite3_column_int(sqlStatment,0);
            newSectionQuestion.PresentationID  = sqlite3_column_int(sqlStatment,1);
            newSectionQuestion.QuestionSectionID =sqlite3_column_int(sqlStatment,2);
            
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return newSectionQuestion.PresentationID;
    }
}
@end
