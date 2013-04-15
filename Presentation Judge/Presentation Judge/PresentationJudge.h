//
//  PresentationJudge.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentationJudge : NSObject
{
    NSInteger ID;
    NSInteger *JudgeID;
    NSInteger *PresentationID;
}
@property (nonatomic,readonly)   NSInteger ID;
@property (readwrite,assign) NSInteger *JudgeID;
@property (readwrite,assign) NSInteger *PresentationID;
@end