//
//  SectionQuestion.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionQuestion : NSObject
{
    NSInteger ID;
    NSInteger QuestionID;
    NSInteger SectionID;
    NSInteger SubSectionID;
    NSString *Comment;
}
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger QuestionID;
@property (nonatomic,assign) NSInteger SectionID;
@property (nonatomic,assign) NSInteger SubSectionID;
@property (nonatomic,retain) NSString *Comment;
@end
