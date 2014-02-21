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
        
        self.undoManager = [[NSUndoManager alloc] init];
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

- (void)insertObject:(FMModule *)object inModulesAtIndex:(NSUInteger)index
{
    [[self.undoManager prepareWithInvocationTarget:self] removeObjectFromModulesAtIndex:index];
    if (![self.undoManager isUndoing]){
        [self.undoManager setActionName:@"Insert Module"];
    }
    
    [self.modules insertObject:object atIndex:index];
}

- (void)removeObjectFromModulesAtIndex:(NSUInteger)index
{
    FMModule *module = [self.modules objectAtIndex:index];
    
    [[self.undoManager prepareWithInvocationTarget:self] insertObject:module inModulesAtIndex:index];
    if (![self.undoManager isUndoing]){
        [self.undoManager setActionName:@"Remove Module"];
    }
    
    [self.modules removeObjectAtIndex:index];
}

#pragma mark -

@end
