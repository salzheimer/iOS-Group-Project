//
//  SectionDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "SectionDBAccess.h"
#import "Section.h"
#import "SectionQuestionDBAccess.h"
#import "SectionQuestion.h"

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
        if(sqlite3_open([dbPath UTF8String],&SectionDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to SectionDB.");
        }
        const char *sql= "Select id,Name from section";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(SectionDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select All Sections statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Section *newSection = [[Section alloc]init];
            newSection.ID = sqlite3_column_int(sqlStatment,0);
            newSection.Section_Name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
            
            [sectionArray addObject:newSection];
        }
         sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        sqlite3_close(SectionDB);
        return sectionArray;
    }


}
- (Section *) getSectionsBySectionID:(int) sectionID
{
    Section *newSection = [[Section alloc]init];
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],&SectionDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured opening SectionDB.");
        }
        NSString *sql = [NSString stringWithFormat:@"Select id,Name from section where id= %d",sectionID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(SectionDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select section by sectionID statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            newSection.ID = sqlite3_column_int(sqlStatment,0);
            newSection.Section_Name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
            
        }
         sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        sqlite3_close(SectionDB);
        return newSection;
    }

}
-(NSMutableArray *)getSectionsByPresentationID:(int) presentationID
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
        if(sqlite3_open([dbPath UTF8String],&SectionDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to SectionDB.");
        }
        NSString *sql = [NSString stringWithFormat:@"select sectionid,name from PresentationQuestions pq inner join SectionQuestion sq on pq.questionsectionid = sq.id inner join Section s on sq.sectionid = s.id where presentationid =%d group by sq.sectionid",presentationID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(SectionDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select sectionid by presentationid statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Section *newSection = [[Section alloc]init];
            newSection.ID = sqlite3_column_int(sqlStatment,0);
            newSection.Section_Name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
            
            [sectionArray addObject:newSection];
        }
         sqlite3_reset(sqlStatment);
    }
    @catch(NSException *ex)
    {
                sqlite3_close(SectionDB);
        NSLog(@"an exception occured in getsectionbypresentationid: %@",[ex reason]);
    }
    @finally
    {
        sqlite3_close(SectionDB);
        return sectionArray;
    }
    
}
-(NSInteger) getSectionCountByPresentationID:(int) presentationID
{
    NSMutableArray *sections =[self getSectionsByPresentationID: presentationID];
    return  sections.count;
}
-(NSString *) getPresentation_SectionNameForIndex: (int) index presentationID:(int) presentationID
{
    NSMutableArray *secArray = [self getSectionsByPresentationID: presentationID];
    Section *sec = [secArray objectAtIndex:index];
    return sec.Section_Name;
}
-(Section *) getPresentation_SectionForIndex: (int) index presentationID:(int) presentationID
{
    NSMutableArray *secArray = [self getSectionsByPresentationID: presentationID];
    Section *sec = [secArray objectAtIndex:index];
    return sec;
}
@end
