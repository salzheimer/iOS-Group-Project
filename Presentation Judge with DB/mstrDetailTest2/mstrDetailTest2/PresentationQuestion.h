//
//  PresentatinQuestion.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentationQuestion : NSObject
{
    NSInteger ID;
    NSInteger QuestionSectionID;
    NSInteger PresentationID;
}
@property   (nonatomic,assign)      NSInteger ID;
@property   (nonatomic,assign)      NSInteger QuestionSectionID;
@property   (nonatomic,assign)      NSInteger PresentationID;
@end
