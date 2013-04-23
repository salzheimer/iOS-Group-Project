//
//  JudgeDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "JudgeDBAccess.h"
#import "Judge.h"
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
        if(sqlite3_open([dbPath UTF8String],& judgeDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,FirstName.LastName,Email from Judge";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(judgeDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
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
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return judgeArray;
    }
    

}

@end
