//
//  QuestionDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "QuestionDBAccess.h"
#import "Question.h"
@implementation QuestionDBAccess
-(NSMutableArray *) getSubSections
{    NSMutableArray *questionArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& QuestionDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,Question from Question";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(QuestionDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Question *newQuestion = [[Question alloc]init];
            newQuestion.ID = sqlite3_column_int(sqlStatment,0);
            newQuestion.Question  = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
            
            [questionArray addObject:newQuestion];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return questionArray;
    }
    
    
}

@end
