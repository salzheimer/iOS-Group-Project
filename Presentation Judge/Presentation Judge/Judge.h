//
//  Judge.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Judge : NSObject
{
    NSInteger ID;
    NSString *FirstName;
    NSString *LastName;
    NSString *Email;
}
@property (nonatomic,readonly) NSInteger ID;
@property (readwrite,retain) NSString *FirstName;
@property (readwrite,retain) NSString *LastName;
@property (readwrite,retain) NSString *Email;
@end

