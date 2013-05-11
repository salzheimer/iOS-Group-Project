//
//  JudgeDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "JudgeDBAccess.h"
#import "Judge.h"
#import "PresentationJudgeDBAccess.h"
#import "PresentationJudge.h"

@implementation JudgeDBAccess

-(NSMutableArray *) getJudges
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
        if(sqlite3_open([dbPath UTF8String],& judgeDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to JudgeDb. ");
        }
        const char *sql= "Select id,FirstName.LastName,Email from Judge";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(judgeDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select all judges statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Judge *newJudge = [[Judge alloc]init];
            newJudge.ID = sqlite3_column_int(sqlStatment,0);
            newJudge.FirstName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1)];
            newJudge.LastName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,2)];
            newJudge.Email  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,3)];
            
            [judgeArray addObject:newJudge];
        }
         sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {        sqlite3_close(judgeDB);
        return judgeArray;
    }
    

}
-(NSMutableArray *) getJudgesByPresentationID: (int) presentationID;
{
       NSMutableArray *judgeArray =[[NSMutableArray alloc]init];
    PresentationJudgeDBAccess *pjDB = [[PresentationJudgeDBAccess alloc]init];
    NSMutableArray *judges =[pjDB getPresnetationJudgesByPresentationID:presentationID];
    for (int i=0;i< judges.count; i++)
    {
        Judge *newJudge = [[Judge alloc]init];
        PresentationJudge *presJudge =judges[i];
        newJudge =[self getJudgeByJudgeID: presJudge.JudgeID];
        [judgeArray addObject:newJudge];
    };
    return judgeArray;
}
-(Judge *) getJudgeByJudgeID:(int) judgeID
{
   // NSMutableArray *judgeArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& judgeDB)!= SQLITE_OK)
        {
            NSLog(@"Connected to judge Failed.");
        }
         NSString *sql = [NSString stringWithFormat:@"Select id,FirstName,LastName,Email from Judge where ID =%d",judgeID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(judgeDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select Judges by id statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Judge *newJudge = [[Judge alloc]init];
            newJudge.ID = sqlite3_column_int(sqlStatment,0);
            newJudge.FirstName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1)];
            newJudge.LastName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,2)];
            newJudge.Email  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,3)];
            
            return newJudge;
        }
         sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
        sqlite3_close(judgeDB);
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        sqlite3_close(judgeDB);
    }
    
    
}
@end
