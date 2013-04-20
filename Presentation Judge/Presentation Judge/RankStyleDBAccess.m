//
//  RankStyleDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "RankStyleDBAccess.h"
#import "RankStyle.h"
@implementation RankStyleDBAccess

-(NSMutableArray *) getRankStyles
{
    
    NSMutableArray *rankStyleArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& rankStyleDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,StyleName from RankStyle";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(rankStyleDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            RankStyle *newRankStyle = [[RankStyle alloc]init];
            newRankStyle.ID = sqlite3_column_int(sqlStatment,0);
            newRankStyle.StyleName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1)];
           
            [rankStyleArray addObject:newRankStyle];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return rankStyleArray;
    }
    
    
    
}
@end


