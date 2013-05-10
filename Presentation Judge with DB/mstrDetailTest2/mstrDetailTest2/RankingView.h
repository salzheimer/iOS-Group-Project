//
//  RankingView.h
//  mstrDetailTest2
//
//  Created by skadoo on 5/9/13.
//  Copyright (c) 2013 skadoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingView : NSObject
{
    NSInteger ID;
    NSString *TextValue;
}
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,retain)   NSString *TextValue;
@end
