//
//  SectionQuestionDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "SectionQuestionDBAccess.h"
#import "SectionQuestion.h"
#import "PresentationQuestionsDBAccess.h"
#import "PresentationQuestion.h"

@implementation SectionQuestionDBAccess

-(NSMutableArray *) getPresentationSections
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
        if(sqlite3_open([dbPath UTF8String],& sqDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to db.");
        }
        const char *sql= "Select id,QuestionID,SectionID,SubSectionID,Comments from SectionQuestion";
        sqlite3_stmt *sqlStatment;
        if(sqlite3_prepare(sqDB,sql,-1,&sqlStatment,NULL)!= SQLITE_OK)
        {
            NSLog(@"Problem with Section Question Select statement");
        }
        
        while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
        {
            
            SectionQuestion *newSectionQuestion = [[SectionQuestion alloc]init];
            newSectionQuestion.ID = sqlite3_column_int(sqlStatment,0);
            if(sqlite3_column_type(sqlStatment,1)!=SQLITE_NULL)
            {
            newSectionQuestion.QuestionID  = sqlite3_column_int(sqlStatment,1);
            }
            else
            {newSectionQuestion.QuestionID=0;
            }
            if(sqlite3_column_type(sqlStatment,2)!=SQLITE_NULL)
            {
            newSectionQuestion.SectionID =sqlite3_column_int(sqlStatment,2);
            }else
            {
                newSectionQuestion.SectionID =0;
            }
            if(sqlite3_column_type(sqlStatment,3)!=SQLITE_NULL)
            {
            newSectionQuestion.SubSectionID =sqlite3_column_int(sqlStatment,3);
            }
            else
            {
                newSectionQuestion.SubSectionID =0;
            }
            if(sqlite3_column_type(sqlStatment,4)!=SQLITE_NULL)
            {
            newSectionQuestion.Comment =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,4) ];
            }
            else
            {
                newSectionQuestion.Comment=@"";
            }
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
-(NSInteger) countSectionsByPresentationID:(int) presentationID
{
    NSInteger count = 0;
    SectionQuestion *secQ = [[SectionQuestion alloc]init];
    NSMutableArray *sections = self.getPresentationSections;
    
    PresentationQuestionsDBAccess *preQ = [[PresentationQuestionsDBAccess alloc]init];
   NSInteger questionSectionID =  [preQ getQuestionSectionIDByPresentationID:presentationID];
    for(int i=1; i< sections.count;i++)
    {
        secQ = sections[i];
      
      if(secQ.QuestionID== questionSectionID)
      {
          count ++;
      }
    }
    return count;
}
-(NSMutableArray *) getSectionQuestionsByPresentationID: (int) presentationID
{
       NSMutableArray *questionSectionArray =[[NSMutableArray alloc]init];
    
    PresentationQuestionsDBAccess *pqDB =[[PresentationQuestionsDBAccess alloc]init];
    NSMutableArray *presQues= [pqDB getPresentationQuestions:presentationID];
    
    
        @try
        {
            
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *dbPath=[[[NSBundle mainBundle]    resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
            BOOL success = [fileMgr fileExistsAtPath:dbPath];
            if(!success)
            {
                NSLog(@"Can not locate database file '%@'.",dbPath);
            }
            if(sqlite3_open([dbPath UTF8String],& sqDB)== SQLITE_OK)
            {
                NSLog(@"An error occured.");
            }
            // loop thru presentation questions array
            for(int i=0;i< presQues.count;i++)
            {
                PresentationQuestion *pq = presQues[i];
                NSString *sql = [NSString stringWithFormat:@"Select id,QuestionID,SectionID,SubSectionID,Comments from SectionQuestion where sectionid=%d",pq.QuestionSectionID];
                sqlite3_stmt *sqlStatment;
                if(sqlite3_prepare(sqDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
                {
                    NSLog(@"Problem with Section Question select by questionsectionid statement");
                }
            
                while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
                {
                
                    SectionQuestion *newSectionQuestion = [[SectionQuestion alloc]init];
                    if(sqlite3_column_type(sqlStatment,1)!=SQLITE_NULL)
                    {
                        newSectionQuestion.QuestionID  = sqlite3_column_int(sqlStatment,1);
                    }
                    else
                    {newSectionQuestion.QuestionID=0;
                    }
                    if(sqlite3_column_type(sqlStatment,2)!=SQLITE_NULL)
                    {
                        newSectionQuestion.SectionID =sqlite3_column_int(sqlStatment,2);
                    }else
                    {
                        newSectionQuestion.SectionID =0;
                    }
                    if(sqlite3_column_type(sqlStatment,3)!=SQLITE_NULL)
                    {
                        newSectionQuestion.SubSectionID =sqlite3_column_int(sqlStatment,3);
                    }
                    else
                    {
                        newSectionQuestion.SubSectionID =0;
                    }
                    if(sqlite3_column_type(sqlStatment,4)!=SQLITE_NULL)
                    {
                        newSectionQuestion.Comment =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,4) ];
                    }
                    else
                    {
                        newSectionQuestion.Comment=@"";
                    }

                
                    [questionSectionArray addObject:newSectionQuestion];
                }
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
-(NSMutableArray *) getSectionQuestionsBySectionID: (int) sectionID
{
    NSMutableArray *questionSectionArray =[[NSMutableArray alloc]init];
    
        
    @try
    {
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath=[[[NSBundle mainBundle]    resourcePath]stringByAppendingPathComponent:@"PresentationJudge.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Can not locate database file '%@'.",dbPath);
        }
        if(sqlite3_open([dbPath UTF8String],& sqDB)== SQLITE_OK)
        {
            NSLog(@"An error occured.");
        }
                    NSString *sql = [NSString stringWithFormat:@"Select id,QuestionID,SectionID,SubSectionID,Comments from SectionQuestion where sectionid=%d",sectionID];
            sqlite3_stmt *sqlStatment;
            if(sqlite3_prepare(sqDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
            {
                NSLog(@"Problem with Section Question select by questionsectionid statement");
            }
            
            while(sqlite3_step(sqlStatment) ==SQLITE_ROW)
            {
                
                SectionQuestion *newSectionQuestion = [[SectionQuestion alloc]init];
                if(sqlite3_column_type(sqlStatment,1)!=SQLITE_NULL)
                {
                    newSectionQuestion.QuestionID  = sqlite3_column_int(sqlStatment,1);
                }
                else
                {newSectionQuestion.QuestionID=0;
                }
                if(sqlite3_column_type(sqlStatment,2)!=SQLITE_NULL)
                {
                    newSectionQuestion.SectionID =sqlite3_column_int(sqlStatment,2);
                }else
                {
                    newSectionQuestion.SectionID =0;
                }
                if(sqlite3_column_type(sqlStatment,3)!=SQLITE_NULL)
                {
                    newSectionQuestion.SubSectionID =sqlite3_column_int(sqlStatment,3);
                }
                else
                {
                    newSectionQuestion.SubSectionID =0;
                }
                if(sqlite3_column_type(sqlStatment,4)!=SQLITE_NULL)
                {
                    newSectionQuestion.Comment =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatment,4) ];
                }
                else
                {
                    newSectionQuestion.Comment=@"";
                }
                
                
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
