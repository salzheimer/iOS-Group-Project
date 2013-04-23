//
//  SectionDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "SectionDBAccess.h"
#import "Section.h"
@implementation SectionDBAccess
-(NSMutableArray *) getSections
{
    NSMutableArray *sectionArray =[[NSMutableArray alloc]init];
   
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],&SectionDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,SectionName from section";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(SectionDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Section *newSection = [[Section alloc]init];
            newSection.ID = sqlite3_column_int(sqlStatment,0);
            newSection.Section_Name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
            
            [sectionArray addObject:newSection];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return sectionArray;
    }


}

@end
