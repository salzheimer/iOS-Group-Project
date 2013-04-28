//
//  PrensenterDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "PresenterDBAccess.h"
#import "Presenter.h"

@implementation PresenterDBAccess
-(NSMutableArray *) getPresenters
{
    NSMutableArray *presenterArray =[[NSMutableArray alloc]init];
    
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& presenterDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to db.");
        }
        const char *sql= "Select id,FirstName,LastName,Email from Presenter";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(presenterDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Select all presenters statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Presenter *newPresenter = [[Presenter alloc]init];
            newPresenter.ID = sqlite3_column_int(sqlStatment,0);
            newPresenter.FirstName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1)];
            newPresenter.LastName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,2)];
            newPresenter.Email  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,3)];
            
            [presenterArray addObject:newPresenter];
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        return presenterArray;
    }
}    
-(Presenter *)getPresenterByID: (int) presenterID
{ 
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& presenterDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to db.");
        }
        NSString *sql = [NSString stringWithFormat:@"Select id,FirstName,LastName,Email from Presenter where ID =%d",presenterID];
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(presenterDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with select presenter by id statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            Presenter *newPresenter = [[Presenter alloc]init];
            newPresenter.ID = sqlite3_column_int(sqlStatment,0);
            newPresenter.FirstName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1)];
            newPresenter.LastName  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,2)];
            newPresenter.Email  =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,3)];
            return newPresenter;
          
        }
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
  

  }


@end
