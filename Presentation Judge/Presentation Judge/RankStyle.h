//
//  RankStyle.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankStyle : NSObject
{
    NSInteger ID;
    NSString *StyleName;
}
@property (nonatomic,readonly) NSInteger ID;
@property (nonatomic,retain)   NSString *StyleName;
@end
