//
//  Presesntation.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Presentation : NSObject
{
    NSInteger   ID;
    NSString    *Title;
    NSInteger   RankStyleID;
    NSString    *ScaleLowerBound;
    NSString    *ScaleUpperBound;
    NSString    *Comments;
}
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,retain) NSString *Title;
@property (nonatomic,assign) NSInteger RankStyleID;
@property (nonatomic,retain) NSString *ScaleLowerBound;
@property (nonatomic,retain) NSString *ScaleUpperBound;
@property (nonatomic,retain) NSString *Comments;

@end
