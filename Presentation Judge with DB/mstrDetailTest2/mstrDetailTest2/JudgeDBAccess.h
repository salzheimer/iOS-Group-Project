//
//  JudgeDBAccess.h
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Judge.h"
@interface JudgeDBAccess : NSObject
{
    sqlite3 *judgeDB;
}
-(NSMutableArray *) getJudges;
-(Judge * ) getJudgeByJudgeID:(int) judgeID;
-(NSMutableArray *) getJudgesByPresentationID: (int) presentationID;
@end
