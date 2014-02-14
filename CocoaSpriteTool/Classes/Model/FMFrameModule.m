//
//  FMFrameModule.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMFrameModule.h"
#import "NSString+FM.h"

@interface FMFrameModule ()

@property (nonatomic, strong) FMFrame *frame;
@property (nonatomic, strong) NSString *uuid;

@end

@implementation FMFrameModule

- (id)initWithFrame:(FMFrame *)frame
               uuid:(NSString *)uuid
             module:(FMModule *)module
                  x:(NSInteger)x
                  y:(NSInteger)y
{
    if (self = [super init]) {
        self.frame = frame;
        self.uuid = uuid;
        self.module = module;
        self.x = x;
        self.y = y;
    }
    return self;
}

+ (FMFrameModule *)frameModuleInFrame:(FMFrame *)frame
{
    FMFrameModule *frameModule = [[FMFrameModule alloc] initWithFrame:frame
                                                                 uuid:[NSString uuid]
                                                               module:nil
                                                                    x:0
                                                                    y:0];
    
    return frameModule;
}

@end
