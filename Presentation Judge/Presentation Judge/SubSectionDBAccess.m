//
//  SubSectionDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "SubSectionDBAccess.h"
#import "SubSection.h"
@implementation SubSectionDBAccess
-(NSMutableArray *) getSubSections
{    NSMutableArray *subSectionArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& SubSectionDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
        const char *sql= "Select id,SubSectionName from SubSection";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(SubSectionDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            SubSection *newSection = [[SubSection alloc]init];
            newSection.ID = sqlite3_column_int(sqlStatment,0);
            newSection.SubSection_Name  = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
            
            [subSectionArray addObject:newSection];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return subSectionArray;
    }
    
    
}
@end
