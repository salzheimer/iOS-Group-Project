//
//  PresentationJudgeDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "PresentationJudgeDBAccess.h"
#import "PresentationJudge.h"

@implementation PresentationJudgeDBAccess
-(NSMutableArray *) getPresnetationJudges
{
    NSMutableArray *presentationJudgeArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& pjDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to db.");
        }
        const char *sql= "Select id,PresenterID,PresentationID from PresenterPresentation";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(pjDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select all presentation presenters statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            PresentationJudge *newPresentationJudge = [[PresentationJudge alloc]init];
            newPresentationJudge.ID = sqlite3_column_int(sqlStatment,0);
            newPresentationJudge.JudgeID= sqlite3_column_int(sqlStatment,1);
            newPresentationJudge.PresentationID = sqlite3_column_int(sqlStatment,2);
            [presentationJudgeArray addObject:newPresentationJudge];
        }
         sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
        sqlite3_close(pjDB);
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {          sqlite3_close(pjDB);
        return presentationJudgeArray;
    }
    
    
    
}
-(NSMutableArray *) getPresnetationJudgesByPresentationID: (int) presentationID
{
    NSMutableArray *judgeArray =[[NSMutableArray alloc]init];
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],&pjDB)!= SQLITE_OK)
        {
            NSLog(@"Error occurred connecting to DB.");
        }
        //const char *sql= "Select id,title,ranksyleid,scalelowerbound,scaleupperbound,comments from presentation where ID= ";
        NSString *sql = [NSString stringWithFormat:@"Select id,judgeID,presentationID from PresentationJudge where PresentationID= %d", presentationID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(pjDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select presentation presenters by presentationid statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            PresentationJudge *newPresentationJudge = [[PresentationJudge alloc]init];
            newPresentationJudge.ID = sqlite3_column_int(sqlStatment,0);
            newPresentationJudge.JudgeID= sqlite3_column_int(sqlStatment,1);
            newPresentationJudge.PresentationID = sqlite3_column_int(sqlStatment,2);
            [judgeArray addObject:newPresentationJudge];
        }
     sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
        sqlite3_close(pjDB);
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        sqlite3_close(pjDB);
        return judgeArray;
    }


}

@end
