//
//  FMModulesView.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FMModule;
@class FMModulesRenderView;
@protocol FMModulesRenderViewDelegate <NSObject>

- (void)modulesRenderViewMouseDown:(FMModulesRenderView *)modulesRenderView;
- (void)modulesRenderViewMouseUp:(FMModulesRenderView *)modulesRenderView;
- (void)modulesRenderViewMouseMoved:(FMModulesRenderView *)modulesRenderView;

- (BOOL)moduleSelected:(FMModule *)module;

@end

@interface FMModulesRenderView : NSView

@property (nonatomic, strong) id<FMModulesRenderViewDelegate> delegate;
@property (nonatomic, strong) NSImage *image;

@property (nonatomic, strong) NSArray *modules;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGPoint translate;

@end
