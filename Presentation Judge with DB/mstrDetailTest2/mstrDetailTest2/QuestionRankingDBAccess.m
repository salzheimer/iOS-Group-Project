//
//  QuestionRAnkingDBAccess.m
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import "QuestionRankingDBAccess.h"
#import "QuestionRanking.h"
@implementation QuestionRankingDBAccess
/*-(QuestionRanking *) getPresentationRanking: (int) presentationID
{
    

}*/

-(void) SavePresentationRanking:(QuestionRanking *) ranking
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
        if(sqlite3_open([dbPath UTF8String],& questionRankingDB)!= SQLITE_OK)
        {
            NSLog(@"An error occured connecting to questionrankingDB. ");
        }
       
            NSString *sql = [NSString stringWithFormat:@"Insert into QuestionRanking ('QuestionID','Ranking','PresentationID') values('%d','%@','%d')",ranking.QuestionID,ranking.Ranking,ranking.PresentationID];
      
            sqlite3_stmt *sqlStatment;
            char *err;
            if(sqlite3_prepare_v2(questionRankingDB,[sql UTF8String],-1,&sqlStatment,NULL)!= SQLITE_OK)
            {
                NSLog(@"Problem with Insert Question Ranking");
                return;
            }
          
                if(sqlite3_step(sqlStatment) == SQLITE_DONE)
                {
                     sqlite3_finalize(sqlStatment);
                    sqlite3_close(questionRankingDB);
                }
              
            /*    if( sqlite3_exec(questionRankingDB, [sql UTF8String],NULL,NULL,&err)!=SQLITE_OK)
            {
                sqlite3_close(questionRankingDB);
                NSAssert(0,@"Could not update ranking");
            }
            else
            {
               NSLog(@"ranking inserted successfully");
            }
        */
        
    }
    @catch(NSException *ex)
    {
        NSLog(@"an exception occured: %@",[ex reason]);
    }
    @finally
    {
        sqlite3_close(questionRankingDB);
    }


}
@end
