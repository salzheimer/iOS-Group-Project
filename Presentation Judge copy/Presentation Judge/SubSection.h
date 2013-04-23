//
//  SubSection.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SubSection : NSObject
{
    NSInteger ID;
    NSString *SubSection_Name;
}



@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,retain) NSString *SubSection_Name;
@end