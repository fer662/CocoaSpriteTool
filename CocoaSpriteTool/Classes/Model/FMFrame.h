//
//  FMFrame.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMSprite;
@class FMFrameModule;
@interface FMFrame : NSObject

+ (FMFrame *)frameInSprite:(FMSprite *)sprite;

@property (nonatomic, strong, readonly) FMSprite *sprite;
@property (nonatomic, strong, readonly) NSString *uuid;

@property (nonatomic, strong, readonly) NSArray *frameModules;

- (FMFrameModule *)newFrameModule;

@end
