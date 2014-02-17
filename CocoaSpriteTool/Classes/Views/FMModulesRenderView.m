//
//  FMModulesView.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMModulesRenderView.h"
#import "FMModule.h"

NSString *const kSelectedModulesBindingKeyPath= @"selectedModules";
NSString *const kAllModulesBindingKeyPath= @"allModules";

typedef enum
{
    FMModulesRenderViewNone,
    FMModulesRenderViewMovingModules
} FMModulesRenderViewState;

@interface FMModulesRenderView ()

@property (nonatomic, assign) CGPoint lastMousePosition;
@property (nonatomic, assign) BOOL mouseDown;
@property (nonatomic, assign) FMModulesRenderViewState state;

@end

@implementation FMModulesRenderView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scale = 1;
        self.translate = CGPointMake(0, 0);
        self.drawAll = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    NSDictionary *options = @{ NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    [self bind:kSelectedModulesBindingKeyPath
      toObject:self.arrayController
   withKeyPath:@"selectedObjects"
       options:options];
    [self bind:kAllModulesBindingKeyPath
      toObject:self.arrayController
   withKeyPath:@"arrangedObjects"
       options:options];
}

- (CGPoint)mousePositionInViewFromEvent:(NSEvent *)event
{
    CGPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    point.y = self.frame.size.height - point.y;
    return point;
}

- (void)mouseDown:(NSEvent *)event
{
    CGPoint point = [self mousePositionInViewFromEvent:event];
    
    BOOL holdingControl = ((event.modifierFlags & NSControlKeyMask) != 0);
    
    for (FMModule *module in self.allModules) {
        if (CGRectContainsPoint(module.rectangle, point)) {
            if (![self.arrayController.selectedObjects containsObject:module]) {
                
                if (holdingControl) {
                    [self.arrayController addSelectedObjects:@[module]];
                }
                else {
                    [self.arrayController setSelectedObjects:@[module]];
                    break;
                }
            }
            else {
                if (holdingControl) {
                    [self.arrayController removeSelectedObjects:@[module]];
                }
                else {
                    [self.arrayController setSelectedObjects:@[module]];
                    break;
                }
            }
        }
    }
    
    self.lastMousePosition = point;
    self.mouseDown = YES;
    
    self.state = FMModulesRenderViewMovingModules;
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event
{
    CGPoint position = [self mousePositionInViewFromEvent:event];
    CGPoint delta = CGPointMake(position.x - self.lastMousePosition.x, position.y - self.lastMousePosition.y);
    if (self.mouseDown) {
        switch (self.state) {
            case FMModulesRenderViewMovingModules:
                for (FMModule *module in self.selectedModules) {
                    module.x += delta.x;
                    module.y += delta.y;
                }
                break;
        }
    }
    
    self.lastMousePosition = position;
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    self.mouseDown = NO;
    self.state = FMModulesRenderViewNone;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef content = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height);
    CGContextConcatCTM(content, flipVertical);
    
    [[NSColor blackColor] setFill];
    CGContextFillRect(content, dirtyRect);
    
    CGContextTranslateCTM(content, self.translate.x, self.translate.y);
    CGContextScaleCTM(content, self.scale, self.scale);
    
    if (self.image) {
        NSRect proposedRect = NSMakeRect(0, 0, self.image.size.width, self.image.size.height);
        CGImageRef imageRef = [self.image CGImageForProposedRect:&proposedRect
                                                         context:[NSGraphicsContext currentContext] hints:nil];
        CGContextDrawImage(content, CGRectMake(0, 0, self.image.size.width, self.image.size.height), imageRef);
    }
    
    if (self.drawAll) {
        NSMutableArray *unselectedModules = [self.allModules mutableCopy];
        [unselectedModules removeObjectsInArray:self.selectedModules];
        
        [[[NSColor redColor] colorWithAlphaComponent:0.5] setStroke];
        for (FMModule *module in unselectedModules) {
           // [self drawModule:module inContext:content];
        }
    }
    [[NSColor blueColor] setStroke];

    for (FMModule *module in self.selectedModules) {
        [self drawModule:module inContext:content];
    }
}

- (void)drawModule:(FMModule *)module inContext:(CGContextRef)context
{
    CGFloat dashLengths[] = { 2, 2 };
    CGContextSetLineDash( context, 0, dashLengths, sizeof( dashLengths ) / sizeof( float ) );
    CGContextSetLineWidth(context, 1);
    
    CGContextMoveToPoint(context, module.x, module.y);
    CGContextAddLineToPoint(context, module.x, module.y + module.height);
    CGContextAddLineToPoint(context, module.x + module.width, module.y + module.height);
    CGContextAddLineToPoint(context, module.x + module.width, module.y);
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
}

@end
