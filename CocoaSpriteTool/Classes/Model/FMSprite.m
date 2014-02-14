//
//  FMSprite.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMSprite.h"

@interface FMSprite ()

@property (nonatomic, strong) NSMutableArray *modules;
@property (nonatomic, strong) NSMutableArray *frames;
@property (nonatomic, strong) NSMutableArray *animations;

@end

@implementation FMSprite

- (id)init
{
    self = [super init];
    if (self) {
        self.modules = [NSMutableArray array];
        self.frames = [NSMutableArray array];
        self.animations = [NSMutableArray array];
    }
    return self;
}

- (FMModule *)addModule
{
    FMModule *newModule = [FMModule moduleInSprite:self];
    [self.modules addObject:newModule];
    
    return newModule;
}

- (FMFrame *)addFrame
{
    FMFrame *newFrame = [FMFrame frameInSprite:self];
    [self.frames addObject:newFrame];
    
    return newFrame;
}

- (FMAnimation *)addAnimation
{
    return nil;
}

#pragma mark -

@end
