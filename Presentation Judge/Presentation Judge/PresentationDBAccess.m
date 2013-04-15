//
//  PresentationDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "PresentationDBAccess.h"
#import "Presentation.h"    
@implementation PresentationDBAccess


-(NSMutableArray *) getPresentations
    {
        NSMutableArray *presentationArray = [[NSMutableArray alloc]init];
        @try
        {
           
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *dbPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
            BOOL success = [fileMgr fileExistsAtPath:dbPath];
            if(!success)
            {
                NSLog(@"Can not locate database file '%@'.",dbPath);
            }
            if(sqlite3_open([dbPath UTF8String],&PresentationDB)== SQLITE_OK)
            {
                NSLog(@"An error occured.");
            }
            const char *sql= "Select id,title,scalelowerbound,scaleupperbound,comments from presentation";
            sqlite3_stmt *sqlStatment;
            if(sqlite3_prepare(PresentationDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
            {
                NSLog(@"Problem with prepare statement");
            }
            
            while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
            {
                
                Presentation *newPresentation = [[Presentation alloc]init];
                newPresentation.ID = sqlite3_column_int(sqlStatment,0);
                newPresentation.Title = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,1) ];
                newPresentation.RankStyleID =  sqlite3_column_int(sqlStatment,2);
               newPresentation.ScaleLowerBound  =[ NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,3) ];
                
                newPresentation.ScaleUpperBound  =[ NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,4) ];
                
                newPresentation.Comments  =[ NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,5) ];
                
                [presentationArray addObject:newPresentation];
            }
        }
        @catch(NSException *ex)
        {
            NSLog(@"an exception occured: %@",[ex reason]);
        }
        @finally
        {
            return presentationArray;
        }
    }





@end
