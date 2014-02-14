//
//  FMFrameModule.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMFrame;
@class FMModule;
@interface FMFrameModule : NSObject

+ (FMFrameModule *)frameModuleInFrame:(FMFrame *)frame;

@property (nonatomic, strong, readonly) FMFrame *frame;
@property (nonatomic, strong, readonly) NSString *uuid;

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, strong) FMModule *module;

@end
