//
//  SectionQuestionDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "SectionQuestionDBAccess.h"
#import "SectionQuestion.h"
@implementation SectionQuestionDBAccess

-(NSMutableArray *) getPreseantionSections
{    NSMutableArray *questionSectionArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& sqDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,QuestionID,SectionID,SubSectionID,Comments from SectionQuestion";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(sqDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            SectionQuestion *newSectionQuestion = [[SectionQuestion alloc]init];
            newSectionQuestion.ID = sqlite3_column_int(sqlStatment,0);
            newSectionQuestion.QuestionID  = sqlite3_column_int(sqlStatment,1);
            newSectionQuestion.SectionID =sqlite3_column_int(sqlStatment,2);
            newSectionQuestion.SubSectionID =sqlite3_column_int(sqlStatment,3);
            newSectionQuestion.Comment =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,4) ];
            
            [questionSectionArray addObject:newSectionQuestion];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return questionSectionArray;
    }
    
    
}

@end
