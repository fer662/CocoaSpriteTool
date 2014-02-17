//
//  FMModulesView.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const kSelectedModulesBindingKeyPath;
extern NSString *const kAllModulesBindingKeyPath;

@class FMModule;
@class FMModulesRenderView;

@interface FMModulesRenderView : NSView

@property (nonatomic, strong) NSImage *image;

@property (nonatomic, strong) NSArray *modules;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGPoint translate;

@property (nonatomic, strong) NSArray *selectedModules;
@property (nonatomic, strong) NSArray *allModules;

@property (nonatomic, assign) BOOL drawAll;

@property (nonatomic, strong) IBOutlet NSArrayController *arrayController;

@end
