//
//  PresentationPresenter.h
//  Presentation Judge
//
//  Created by skadoo on 4/13/13.
//  Copyright (c) 2013 S. Alzheimer, L. Malenfant, E. Englert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentationPresenter : NSObject
{
    NSInteger ID;
    NSInteger PresenterID;
    NSInteger PresentationID;
}
@property (nonatomic,assign)    NSInteger ID;
@property (nonatomic,assign)    NSInteger PresenterID;
@property (nonatomic,assign)    NSInteger PresentationID;
@end
