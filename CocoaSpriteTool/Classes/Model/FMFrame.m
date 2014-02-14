//
//  FMFrame.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMFrame.h"
#import "NSString+FM.h"
#import "FMFrameModule.h"

@interface FMFrame ()

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) FMSprite *sprite;

@property (nonatomic, strong) NSMutableArray *mutableFrameModules;

@end

@implementation FMFrame

- (id)initWithSprite:(FMSprite *)sprite
                uuid:(NSString *)uuid
{
    if (self = [super init]) {
        self.sprite = sprite;
        self.uuid = uuid;
        
        self.mutableFrameModules = [NSMutableArray array];
    }
    return self;
}

+ (FMFrame *)frameInSprite:(FMSprite *)sprite
{
    FMFrame *frame = [[FMFrame alloc] initWithSprite:sprite
                                                uuid:[NSString uuid]];
    
    return frame;
}

- (FMFrameModule *)newFrameModule
{
    FMFrameModule *frameModule = [FMFrameModule frameModuleInFrame:self];
    return frameModule;
}

#pragma mark - public accessors

- (NSArray *)frameModules
{
    return self.mutableFrameModules;
}

#pragma mark -

@end
