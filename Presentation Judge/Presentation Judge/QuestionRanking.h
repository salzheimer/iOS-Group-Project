//
//  QuestionRanking.h
//  Presentation Judge
//
//  Created by skadoo on 4/15/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionRanking : NSObject
{
    NSInteger ID;
    NSInteger QuestionID;
    NSString *Ranking;
    NSInteger PresentationID;
}
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger QuestionID;
@property (nonatomic,retain) NSString *Ranking;
@property (nonatomic,assign) NSInteger PresentationID;

@end
