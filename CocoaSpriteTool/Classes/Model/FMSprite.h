//
//  FMSprite.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMModule.h"
#import "FMFrame.h"
#import "FMAnimation.h"

@interface FMSprite : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *modules;
@property (nonatomic, strong, readonly) NSMutableArray *frames;
@property (nonatomic, strong, readonly) NSMutableArray *animations;

@property (nonatomic, strong) NSUndoManager *undoManager;

@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSString *imagePath;

- (FMModule *)addModule;
- (FMFrame *)addFrame;
- (FMAnimation *)addAnimation;

@end
